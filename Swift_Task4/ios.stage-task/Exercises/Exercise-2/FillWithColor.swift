import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        let m = image.count
        let n = image[0].count
        if (m < 0 || n < 0 || m > 50 || n > 50 || newColor < 0 ||
            newColor >= 65536 || row < 0 || row > m || column < 0 || column > n) {
            return image
        } else {
            let oldColor = image[row][column]
            var coloredImage = image
            coloredImage[row][column] = newColor
            if (row - 1 >= 0 && coloredImage[row - 1][column] == oldColor) {
                coloredImage = fillWithColor(coloredImage, row - 1, column, newColor)
            }
            if (row + 1 < m && coloredImage[row + 1][column] == oldColor) {
                coloredImage = fillWithColor(coloredImage, row + 1, column, newColor)
            }
            if (column - 1 >= 0 && coloredImage[row][column - 1] == oldColor) {
                coloredImage = fillWithColor(coloredImage, row, column - 1, newColor)
            }
            if (column + 1 < n && coloredImage[row][column + 1] == oldColor) {
                coloredImage = fillWithColor(coloredImage, row, column + 1, newColor)
            }
            return coloredImage
        }
    }
}
