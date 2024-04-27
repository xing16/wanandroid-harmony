export class TabModel {
  static readonly recommend_id: number = 19999
  static readonly question_id: number = 20000
  courseId?: number
  id?: number
  name?: string
  type?: number

  constructor(id: number, name: string) {
    this.id = id
    this.name = name
  }
}