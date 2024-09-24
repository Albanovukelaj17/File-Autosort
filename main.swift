import Foundation

let file_categories :[String: String] = [
    "jpg": "Pictures",
    "jpeg": "Pictures",
    "png": "Pictures",
    "pdf": "Documents",
    "docx": "Documents",
    "txt": "Documents",
    "mp4": "Videos",
    "mp3": "Music"
]
func organizeFiles(in directory: String) {
    let fileManager = FileManager.default
    let sourceDir = URL(fileURLWithPath: directory)
    let destinationBaseDir = URL(fileURLWithPath: NSHomeDirectory())
    
    // Get all files in the directory
    do {
        let files = try fileManager.contentsOfDirectory(atPath: directory)
        
        for file in files {
            moveFileToCategory(file: file, sourceDir: sourceDir, destinationBaseDir: destinationBaseDir)
        }
    } catch {
        print("Error accessing directory: \(error.localizedDescription)")
    }
}