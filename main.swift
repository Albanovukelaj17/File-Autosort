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


func moveFileToCategory(file: String, sourceDir: URL, destinationBaseDir: URL) {
    // Get the file extension
    let fileExtension = (file as NSString).pathExtension.lowercased()
    
    // Determine the destination folder
    if let categoryFolder = fileCategories[fileExtension] {
        let destinationDir = destinationBaseDir.appendingPathComponent(categoryFolder)
        
        // Create the destination directory if it doesn't exist
        try? FileManager.default.createDirectory(at: destinationDir, withIntermediateDirectories: true)

         // Define the source and destination file paths
        let sourceFile = sourceDir.appendingPathComponent(file)
        let destinationFile = destinationDir.appendingPathComponent(file)
        
        // Move the file
        do {
            try FileManager.default.moveItem(at: sourceFile, to: destinationFile)
            print("Moved \(file) to \(destinationDir.path)")
        } catch {
            print("Failed to move \(file): \(error.localizedDescription)")
        }
    } else {
        print("File type \(fileExtension) not recognized for file \(file).")
    }
}

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