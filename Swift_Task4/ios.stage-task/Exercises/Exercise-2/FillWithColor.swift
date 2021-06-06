import Foundation

final class FillWithColor {
    struct Pixel: Equatable {
        let row: Int
        let column: Int
    }
    
    var array = [Pixel]()
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        if !image.isEmpty {
            let m = image.count
            let n = image[0].count
            if (m < 0 || n < 0 || m > 50 || n > 50 || newColor < 0 ||
                newColor >= 65536 || row < 0 || row >= m || column < 0 || column >= n) {
                return image
            } else {
                array.append(Pixel(row: row, column: column))
                let oldColor = image[row][column]
                var outputImage = image
                outputImage[row][column] = newColor
                if (row - 1 >= 0 && outputImage[row - 1][column] == oldColor) {
                    if !array.contains(Pixel(row: row - 1, column: column)) {
                        outputImage = fillWithColor(outputImage, row - 1, column, newColor)
                    }
                }
                if (row + 1 < m && outputImage[row + 1][column] == oldColor) {
                    if !array.contains(Pixel(row: row + 1, column: column)) {
                        outputImage = fillWithColor(outputImage, row + 1, column, newColor)
                    }
                }
                if (column - 1 >= 0 && outputImage[row][column - 1] == oldColor) {
                    if !array.contains(Pixel(row: row, column: column - 1)) {
                        outputImage = fillWithColor(outputImage, row, column - 1, newColor)
                    }
                }
                if (column + 1 < n && outputImage[row][column + 1] == oldColor) {
                    if !array.contains(Pixel(row: row, column: column + 1)) {
                        outputImage = fillWithColor(outputImage, row, column + 1, newColor)
                    }
                }
                return outputImage
            }
        } else {
            return image
        }
    }
}
