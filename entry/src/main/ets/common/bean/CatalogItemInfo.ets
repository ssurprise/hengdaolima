export class CatalogItemInfo {
  constructor(name: String | Resource, path: string) {
    this.name = name
    this.path = path
  }

  name: String | Resource;
  path: string;
}