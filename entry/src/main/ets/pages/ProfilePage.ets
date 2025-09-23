import promptAction from '@ohos.promptAction';
import bundleManager from '@ohos.bundle.bundleManager';
import router from '@ohos.router';
import { BusinessError } from '@kit.BasicServicesKit';
import { ProblemMockData } from '../mock/ProblemMockData';
import { ProblemModel, ProblemCategory } from '../model/ProblemModel';
import { UserProgressDao } from '../dao/UserProgressDao';

// 菜单项接口定义
interface MenuItem {
  id: string;
  title: string;
  description: string;
  icon: Resource;
  color: string;
  count?: number;
}

interface DataMenuItem {
  id: string;
  title: string;
  description: string;
  icon: Resource;
  color: string;
}

interface OtherMenuItem {
  id: string;
  title: string;
  description: string;
  icon: Resource;
  color: string;
}

@Component
export struct ProfilePage {
  @State totalProblems: number = 0;
  @State totalStudyTime: number = 0;
  @State solvedProblems: number = 0;
  @State practiceCount: number = 0;
  @State examCount: number = 0;
  @State studyDays: number = 0;
  @State isLoading: boolean = true;
  @State showExportDialog: boolean = false;
  @State showImportDialog: boolean = false;
  @State exportProgress: number = 0;
  @State importProgress: number = 0;
  @State userLevel: string = 'LV1';
  @State showAboutSheet: boolean = false;
  @State showFeedbackSheet: boolean = false;
  @State feedbackText: string = '';
  @State versionName: string = '';
  @State userNickname: string = ''; // 用户昵称

  @StorageProp('refreshProfilePage') @Watch('onRefreshProfile') refreshProfile: number = -1;


  // 功能菜单配置
  @State private dataMenuItem: DataMenuItem[] = [
    // {
    //   id: 'category_stats',
    //   title: '分类统计',
    //   description: '查看各个算法分类的练习情况',
    //   icon: $r('app.media.icon_tj'),
    //   color: '#1890ff'
    // },
    // {
    //   id: 'practice_trend',
    //   title: '练习趋势',
    //   description: '查看最近的练习趋势和进度',
    //   icon: $r('app.media.icon_trend'),
    //   color: '#52c41a'
    // },
    // {
    //   id: 'achievement',
    //   title: '成就徽章',
    //   description: '查看已获得的学习成就',
    //   icon: $r('app.media.icon_cj'),
    //   color: '#fa8c16'
    // },
    // {
    //   id: 'exam_history',
    //   title: '考核历史',
    //   description: '查看历史考核记录和成绩',
    //   icon: $r('app.media.icon_history'),
    //   color: '#722ed1'
    // },
    // {
    //   id: 'daily_goal',
    //   title: '学习目标',
    //   description: '设置和管理每日学习目标',
    //   icon: $r('app.media.icon_traget'),
    //   color: '#13c2c2'
    // },
    {
      id: 'wrong_questions',
      title: '错题本',
      description: '复习之前做错的题目',
      icon: $r('app.media.icon_error'),
      color: '#ff7875'
    },
    {
      id: 'favorites',
      title: '我的收藏',
      description: '管理收藏的题目和笔记',
      icon: $r('app.media.icon_like'),
      color: '#fa8c16'
    },
    {
      id: 'study_notes',
      title: '学习笔记',
      description: '查看和管理学习笔记',
      icon: $r('app.media.icon_note'),
      color: '#52c41a'
    }
  ];

  // 其他菜单
  private otherMenuItems: OtherMenuItem[] = [
    {
      id: 'check_update',
      title: '检查更新',
      description: '查看是否有新版本',
      icon: $r('app.media.ic_update'),
      color: '#4CAF50'
    },
    {
      id: 'feedback',
      title: '问题反馈',
      description: '遇到问题？告诉我们',
      icon: $r('app.media.ic_feedback'),
      color: '#FF9800'
    },
    {
      id: 'rate',
      title: '给个好评',
      description: '为应用评分支持',
      icon: $r('app.media.ic_star'),
      color: '#E91E63'
    },
    {
      id: 'about',
      title: '关于应用',
      description: '版本信息和开发者',
      icon: $r('app.media.ic_info'),
      color: '#2196F3'
    }
  ];

  async aboutToAppear() {
    // 初始化数据库
    this.loadData()
    
    // 生成随机用户昵称
    this.generateUserNickname();
    
    bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION).then((bundleInfo) => {
      this.versionName = bundleInfo.versionName;
    }).catch((error: BusinessError) => {
      console.error("get bundleInfo failed,error is " + error)
    })
  }

  /**
   * 生成随机用户昵称
   */
  private generateUserNickname() {
    const randomNum = Math.floor(Math.random() * 9000) + 1000; // 生成 1000-9999 的随机数
    this.userNickname = `算法学习者${randomNum}`;
  }

  onRefreshProfile() {
    if (this.refreshProfile >= 0) {
      this.loadData();
      AppStorage.setOrCreate('refreshProfile', -1);
    }
  }

  async loadData() {
    try {
      this.isLoading = true;
    } catch (error) {
      console.error('加载个人数据失败:', error);
    } finally {
      this.isLoading = false;
    }
  }

  // 处理功能菜单点击
  handleMenuClick(itemId: string) {
    console.info('点击功能菜单：', itemId);
    switch (itemId) {
      case 'category_stats':
        this.navigateToCategoryStats();
        break;
      case 'practice_trend':
        this.navigateToPracticeTrend();
        break;
      case 'achievement':
        this.showAchievements();
        break;
      case 'exam_history':
        this.showExamHistory();
        break;
      case 'daily_goal':
        this.showDailyGoal();
        break;
      case 'wrong_questions':
        this.showWrongQuestions();
        break;
      case 'favorites':
        this.showFavorites();
        break;
      case 'study_notes':
        this.showStudyNotes();
        break;
    }
  }

  // 导航到分类统计页面
  private navigateToCategoryStats() {
    router.pushUrl({
      url: 'pages/CategoryStatsPage'
    }).catch((error: Error) => {
      console.error('Failed to navigate to category stats:', error);
    });
  }

  // 导航到练习趋势页面
  private navigateToPracticeTrend() {
    router.pushUrl({
      url: 'pages/PracticeTrendPage'
    }).catch((error: Error) => {
      console.error('Failed to navigate to practice trend:', error);
    });
  }

  // 显示成就
  private showAchievements() {
    promptAction.showToast({
      message: '成就系统即将上线，敬请期待！',
      duration: 2000
    });
  }

  // 显示考核历史
  private showExamHistory() {
    promptAction.showToast({
      message: '考核历史功能即将上线，敬请期待！',
      duration: 2000
    });
  }

  // 显示学习目标
  private showDailyGoal() {
    promptAction.showToast({
      message: '学习目标设置功能即将上线，敬请期待！',
      duration: 2000
    });
  }

  // 显示错题本
  private showWrongQuestions() {
    router.pushUrl({
      url: 'pages/WrongProblemsPage'
    }).then(() => {
      console.info('✅ 成功导航到错题本页面');
    }).catch((error: Error) => {
      console.error('❌ 导航到错题本页面失败:', error);
    });
  }

  // 显示收藏
  private showFavorites() {
    router.pushUrl({
      url: 'pages/FavoritesPage'
    }).then(() => {
      console.info('✅ 成功导航到收藏页面');
    }).catch((error: Error) => {
      console.error('❌ 导航到收藏页面失败:', error);
    });
  }

  // 显示学习笔记
  private showStudyNotes() {
    router.pushUrl({
      url: 'pages/StudyNotesPage'
    }).then(() => {
      console.info('✅ 成功导航到学习笔记页面');
    }).catch((error: Error) => {
      console.error('❌ 导航到学习笔记页面失败:', error);
      // 如果页面不存在，显示提示
      promptAction.showToast({
        message: '学习笔记功能即将上线，敬请期待！',
        duration: 2000
      });
    });
  }
  handleOtherMenuClick(itemId: string) {
    switch (itemId) {
      case 'check_update':
        this.checkForUpdates();
        break;
      case 'feedback':
        this.openFeedback();
        break;
      case 'rate':
        this.showRateDialog();
        break;
      case 'about':
        this.showAboutDialog();
        break;
    }
  }

  // 检查更新
  private checkForUpdates() {
    // 这里可以实现检查更新的逻辑
    AlertDialog.show({
      title: '检查更新',
      message: '当前已是最新版本',
      primaryButton: {
        value: '确定',
        action: () => {
        }
      }
    });
    console.info('检查更新功能');
  }

  // 打开反馈
  private openFeedback() {
    // 这里可以实现反馈功能
    this.showFeedbackSheet = true;
    console.info('问题反馈功能');
  }

  // 显示评分对话框
  private showRateDialog() {
    // 显示感谢toast
    promptAction.showToast({
      message: '感谢您的支持～',
      duration: 2000
    });
  }

  // 显示关于对话框
  private showAboutDialog() {
    // 这里可以实现关于应用的对话框
    this.showAboutSheet = true;
    console.info('关于应用功能');
  }

  build() {
    Column() {
      if (this.isLoading) {
        // 加载状态
        Column() {
          LoadingProgress()
            .width(50)
            .height(50)
            .color('#FF6B35')
          
          Text('加载中...')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 12 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Scroll() {
          Column() {
            // 顶部个人信息卡片
            Column() {
              Row() {
                // 头像
                Image($r('app.media.ic_mine'))
                  .width(50)
                  .height(50)
                  .borderRadius(25)
                  .margin({ right: 16 })
                  .backgroundColor('#FFFFFF')
                  .padding(10)
                  .shadow({
                    radius: 4,
                    color: 'rgba(0,0,0,0.1)',
                    offsetX: 0,
                    offsetY: 2
                  })
                
                Column() {
                  Text(this.userNickname)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  
                  Text('每天进步一点点')
                    .fontSize(14)
                    .fontColor('#FFE0D6')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 })
                
                Blank()
                Text(this.userLevel)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.brand_color'))
                  .backgroundColor('#FFFFFF')
                  .padding({
                    left: 12,
                    right: 12,
                    top: 6,
                    bottom: 6
                  })
                  .borderRadius(12)
                  .shadow({
                    radius: 2,
                    color: 'rgba(0,0,0,0.1)',
                    offsetX: 0,
                    offsetY: 1
                  })
              }
              .width('100%')
              .margin({ bottom: 20 })

            }
            .width('90%')
            .padding({left: 20, right: 20, bottom: 20, top: 25})
            .backgroundColor('#FF6B35')
            .borderRadius(20)
            .margin({ top: 36, bottom: 6 })

            // 功能菜单
            Column() {
              // 功能设置卡片（包含标题）
              Column() {
                // 分组标题
                Text('我的功能')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.primary_text_color'))
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 16, top: 16, bottom: 8 })

                ForEach(this.dataMenuItem, (item: MenuItem, index: number) => {
                  Column() {
                    Row() {
                      Image(item.icon)
                        .width(20)
                        .height(20)
                        .fillColor($r('app.color.primary_text_color'))
                        .margin({ right: 12 })

                      Column() {
                        Text(item.title)
                          .fontSize(16)
                          .fontColor($r('app.color.primary_text_color'))
                          .fontWeight(FontWeight.Medium)

                        Text(item.description)
                          .fontSize(14)
                          .fontColor($r('app.color.secondary_text_color'))
                          .margin({ top: 2 })
                      }
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)

                      Row() {
                        if (item.count !== undefined) {
                          Text(item.count.toString())
                            .fontSize(14)
                            .fontColor($r('app.color.secondary_text_color'))
                            .margin({ right: 8 })
                        }
                        
                        Image($r('app.media.ic_arrow_right'))
                          .width(20)
                          .height(20)
                          .fillColor($r('app.color.tertiary_text_color'))
                      }
                    }
                    .width('100%')
                    .padding({
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16
                    })
                    .onClick(() => {
                      this.handleMenuClick(item.id);
                    })

                    // 分隔线（最后一项不显示）
                    if (index < this.dataMenuItem.length - 1) {
                      Divider()
                        .color($r('app.color.divider_color'))
                        .strokeWidth(0.5)
                        .margin({ left: 48, right: 16 })
                    }
                  }
                }, (item: MenuItem) => item.id)
              }
              .width('100%')
              .backgroundColor($r('app.color.card_background_color'))
              .borderRadius(12)
              .shadow({
                radius: 2,
                color: $r('app.color.shadow_color'),
                offsetX: 0,
                offsetY: 1
              })
            }
            .width('100%')
            .margin({ top: 14 })
            .padding({ left: 24, right: 24 })

            // 数据管理
            Column() {
              // 数据管理卡片（包含标题）
              Column() {
                // 分组标题
                Text('数据管理')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.primary_text_color'))
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 16, top: 16, bottom: 8 })

              }
              .width('100%')
              .backgroundColor($r('app.color.card_background_color'))
              .borderRadius(12)
              .shadow({
                radius: 2,
                color: $r('app.color.shadow_color'),
                offsetX: 0,
                offsetY: 1
              })
            }
            .width('100%')
            .margin({ top: 24 })
            .padding({ left: 24, right: 24 })
            .visibility(Visibility.None)

            // 其他
            Column() {
              // 其他设置卡片（包含标题）
              Column() {
                // 分组标题
                Text('设置')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.primary_text_color'))
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 16, top: 16, bottom: 8 })

                ForEach(this.otherMenuItems, (item: OtherMenuItem, index: number) => {
                  Column() {
                    Row() {
                      Image(item.icon)
                        .width(20)
                        .height(20)
                        .fillColor($r('app.color.primary_text_color'))
                        .margin({ right: 12 })

                      Column() {
                        Text(item.title)
                          .fontSize(16)
                          .fontColor($r('app.color.primary_text_color'))
                          .fontWeight(FontWeight.Medium)

                        Text(item.description)
                          .fontSize(14)
                          .fontColor($r('app.color.secondary_text_color'))
                          .margin({ top: 2 })
                      }
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)

                      Row() {
                        Image($r('app.media.ic_arrow_right'))
                          .width(20)
                          .height(20)
                          .fillColor($r('app.color.tertiary_text_color'))
                      }
                    }
                    .width('100%')
                    .padding({
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16
                    })
                    .onClick(() => {
                      this.handleOtherMenuClick(item.id);
                    })

                    // 分隔线（最后一项不显示）
                    if (index < this.otherMenuItems.length - 1) {
                      Divider()
                        .color($r('app.color.divider_color'))
                        .strokeWidth(0.5)
                        .margin({ left: 48, right: 16 })
                    }
                  }
                }, (item: OtherMenuItem) => item.id)
              }
              .width('100%')
              .backgroundColor($r('app.color.card_background_color'))
              .borderRadius(12)
              .shadow({
                radius: 2,
                color: $r('app.color.shadow_color'),
                offsetX: 0,
                offsetY: 1
              })
              .bindSheet($$this.showAboutSheet, this.AboutSheet(), {
                height: 400,
                dragBar: true,
                showClose: false,
                preferType:SheetType.CENTER,
                backgroundColor: $r('app.color.surface_color'),
                onDisappear: () => {
                  // 移除状态重置，避免与深色模式切换冲突
                }
              })
            }
            .width('100%')
            .margin({ top: 24, bottom: 24 })
            .padding({ left: 24, right: 24 })
            .bindSheet($$this.showFeedbackSheet, this.FeedbackSheet(), {
              height: 350,
              dragBar: true,
              showClose: false,
              preferType:SheetType.CENTER,
              backgroundColor: $r('app.color.surface_color'),
              onDisappear: () => {
                // 移除状态重置，避免与深色模式切换冲突
              }
            })

          }
        }
        .width('100%')
        .height('100%')
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_color'))

  }


  @Builder
  FeedbackSheet() {
    Column() {
      // Sheet标题
      Text('问题反馈')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.primary_text_color'))
        .margin({ top: 20, bottom: 20 })

      // 输入提示
      Text('请描述您遇到的问题或建议')
        .fontSize(14)
        .fontColor($r('app.color.secondary_text_color'))
        .margin({ bottom: 16 })
        .alignSelf(ItemAlign.Start)

      // 输入框
      TextArea({
        placeholder: '请输入您的问题或建议...',
        text: this.feedbackText
      })
        .width('100%')
        .height(120)
        .fontSize(14)
        .fontColor($r('app.color.primary_text_color'))
        .backgroundColor($r('app.color.input_background_color'))
        .borderRadius(8)
        .padding(12)
        .maxLength(100)
        .onChange((value: string) => {
          this.feedbackText = value;
        })
        .margin({ bottom: 8 })

      // 字数统计
      Text(`${this.feedbackText.length}/100`)
        .fontSize(12)
        .fontColor($r('app.color.tertiary_text_color'))
        .alignSelf(ItemAlign.End)
        .margin({ bottom: 24 })

      // 提交按钮
      Button('提交反馈')
        .width('100%')
        .height(44)
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor($r('app.color.brand_color'))
        .borderRadius(8)
        .enabled(this.feedbackText.trim().length > 0)
        .opacity(this.feedbackText.trim().length > 0 ? 1 : 0.5)
        .onClick(() => {
          if (this.feedbackText.trim().length > 0) {
            promptAction.showToast({
              message: '感谢您的反馈',
              duration: 2000
            });
            this.feedbackText = '';
            this.showFeedbackSheet = false;
          }
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AboutSheet() {
    Column() {
      // Sheet标题
      Text('关于App')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.primary_text_color'))
        .margin({ top: 20, bottom: 20 })

      // 应用图标
      Image($r('app.media.startIcon'))
        .width(80)
        .height(80)
        .borderRadius(16)
        .margin({ bottom: 16 })

      // 应用信息
      Column() {
        Text('算法天天练')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_text_color'))
          .margin({ bottom: 8 })

        Text($r('app.string.version', '版本号', this.versionName))
          .fontSize(14)
          .fontColor($r('app.color.secondary_text_color'))
          .margin({ bottom: 8 })

        Text('您的专业算法学习助手')
          .fontSize(14)
          .fontColor($r('app.color.primary_text_color'))
          .textAlign(TextAlign.Center)
          .margin({ bottom: 16 })

      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Blank()

      // 版权信息
      Text('© 2025 算法天天练团队')
        .fontSize(12)
        .fontColor($r('app.color.tertiary_text_color'))
        .margin({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}