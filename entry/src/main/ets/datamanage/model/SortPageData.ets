export class SortMethod {
  type: SortType;
  name: string;
  description: string = '';
  exampleImg: Resource;
}

export enum SortType {
  'bubble',
  'selection',
  'insert',
  'quick',
}

const examples: number[][] = [
  [9, 8, 7, 6, 5, 4, 3, 2, 1],
  [5, 6, 3, 4, 1, 2],
  [4, 5, 6, 3, 2, 1],
]

const sortMethods: SortMethod[] = [
  {
    type: SortType.bubble,
    name: "冒泡排序",
    description: "思路：比较相邻的元素，如果第一个比第二个大，就交换他们两个。" +
    "\nN个数字冒泡排序，总共要进行N-1趟比较，每趟的排序次数为(N-i)次比较。" +
    "\n时间复杂度：O(n²)",
    exampleImg: $r('app.media.sort_bubble')
  },
  {
    type: SortType.selection,
    name: "选择排序",
    description: "思路：首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置。" +
    "再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。重复第二步，直到所有元素均排序完毕",
    exampleImg: $r('app.media.sort_selection')
  },
  {
    type: SortType.insert,
    name: "插入排序",
    description: "思路：通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。" +
    "\n步骤：首先把第一个元素看做是一个有序序列，把第二个元素到最后一个元素当成是未排序序列。从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。" +
    "\n应用分析：插入排序适用于已经有部分数据已经排好，并且排好的部分越大越好。一般在输入规模大于1000的场合下不建议使用插入排序",
    exampleImg: $r('app.media.sort_insertion')
  },
  {
    type: SortType.insert,
    name: "快速排序",
    description: "原理:使用分治法（Divide and conquer）策略来把一个串行（list）分为两个子串行（sub-lists）。" +
    "\n平均时间复杂度：O(nlogn)，最差时间复杂度：O(n²)",
    exampleImg: $r('app.media.sort_quick')
  },
]

export { sortMethods, examples }