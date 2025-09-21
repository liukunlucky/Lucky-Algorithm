export class UserNoteModel {
  id: number = 0;
  problemId: number = 0;
  content: string = '';
  createdAt: string = '';
  updatedAt: string = '';

  constructor() {
    const now = new Date().toISOString();
    this.createdAt = now;
    this.updatedAt = now;
  }

  updateContent(content: string): void {
    this.content = content;
    this.updatedAt = new Date().toISOString();
  }
}