import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        if !image.isEmpty {
            let m = image.count
            let n = image[0].count
            if (m < 0 || n < 0 || m > 50 || n > 50 || newColor < 0 ||
                newColor >= 65536 || row < 0 || row >= m || column < 0 ||
                column >= n || image[row][column] == newColor) {
                return image
            } else {
                let oldColor = image[row][column]
                var outputImage = image
                outputImage[row][column] = newColor
                
                if (row - 1 >= 0 && image[row - 1][column] == oldColor) {
                    outputImage = fillWithColor(outputImage, row - 1, column, newColor)
                }
                if (row + 1 < m && image[row + 1][column] == oldColor) {
                    outputImage = fillWithColor(outputImage, row + 1, column, newColor)
                }
                if (column - 1 >= 0 && image[row][column - 1] == oldColor) {
                    outputImage = fillWithColor(outputImage, row, column - 1, newColor)
                }
                if (column + 1 < n && image[row][column + 1] == oldColor) {
                    outputImage = fillWithColor(outputImage, row, column + 1, newColor)
                }
                return outputImage
            }
        } else {
            return image
        }
    }
}
