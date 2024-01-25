export class CatalogItemInfo {
  constructor(name: string | Resource, path: string) {
    this.name = name
    this.path = path
  }

  name: string | Resource = '标题';
  path: string;
}