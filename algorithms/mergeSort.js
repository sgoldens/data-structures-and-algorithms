
function createArray(len) {
  let list = []
  for (var i = len - 1; i >= 0; i--) {
    list.push(Math.round(Math.random() * 100 ))
  }
  return list
}

function mergeSort(list) {  
  if (list.length <= 1)
    return list;

  let mid = Math.floor((list.length / 2)),
      left = list.slice(0, mid),
      right = list.slice(mid, list.length)

  return merge(mergeSort(left), mergeSort(right))
}

function merge(left, right) {
  let sorted = [];
  while (left && left.length > 0 && right && right.length > 0) {
    sorted.push(left[0] <= right[0] ? left.shift() : right.shift())
  }
  return sorted.concat(left, right)
}

console.log(mergeSort(createArray(10)))