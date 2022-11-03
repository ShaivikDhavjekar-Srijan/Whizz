//
//  CloudinaryHelper.swift
//  Swiko
//
//  Created by Jitesh Acharya on 14/06/22.
//

import Foundation
import UIKit
import Cloudinary

class CloudinaryHelper {

    static func upload(cloudinary: CLDCloudinary, /*url: URL,*/ resourceType: CLDUrlResourceType, imageData: Data) -> CLDUploadRequest {
        let params = CLDUploadRequestParams()
        params.setResourceType(resourceType)
        params.setFolder(CloudinaryConstants.FOLDER_NAME)

        if (resourceType == CLDUrlResourceType.image) {
            let chain = CLDImagePreprocessChain().addStep(CLDPreprocessHelpers.limit(width: 1500, height: 1500))
                    .setEncoder(CLDPreprocessHelpers.customImageEncoder(format: EncodingFormat.JPEG, quality: 90))
            return cloudinary.createUploader().upload(data: imageData, uploadPreset: CloudinaryConstants.PRESET_KEY, params: params, preprocessChain: chain)  /*uploadLarge(url: url, uploadPreset: "cw9yzb1k", params: params, preprocessChain: chain, chunkSize: 5 * 1024 * 1024)*/
        } else {
            return cloudinary.createUploader().upload(data: imageData, uploadPreset: CloudinaryConstants.PRESET_KEY, params: params) /*cloudinary.createUploader().uploadLarge(url: url, uploadPreset: "cw9yzb1k", params: params, chunkSize: 5 * 1024 * 1024)*/
        }
    }
}
