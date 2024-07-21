export class Image{
  filename: string;
  data: Buffer;
  mimetype: string;
  constructor(filename: string, data: Buffer=null, mimetype: string=""){
    this.filename=filename;
    this.data=data;
    this.mimetype=mimetype;
  }
}
