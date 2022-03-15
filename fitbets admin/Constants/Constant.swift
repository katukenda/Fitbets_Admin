//
//  Constant.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation

let app_id = ""
let rest_key = ""
let device_token = "aaaaaaa"

//base url
let base_url = "http://ec2-35-83-63-15.us-west-2.compute.amazonaws.com:8000/adminnew"

//endpoints
let login_url = "\(base_url)/login"
let register_url = "\(base_url)/register"
let logout_url = "\(base_url)/logout"
let updateProfile_url = "\(base_url)/update/10"


struct TokenKey{
    static let userLogin = "USER_LOGIN_KEY"
   
}

struct profileKey{
    static let userId = "USER_ID"
    static let userName = "USER_NAME"
    static let userEmail = "USER_EMAIL"
    static let userMobile = "USER_MOBILE"
}


let testingToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiaWQiOjEwLCJhZG1pbl9uYW1lIjoia2F0dWtlbmRhMiIsImVtYWlsX2FkZHJlc3MiOiJ0ZWVrc2hhbmFAZ21haWwuY29tIiwibW9iaWxlX251bWJlciI6IjA3Nzc3Nzc3NzciLCJzdGF0dXMiOiJBRE1JTiJ9LCJpYXQiOjE2NDczMzUyMjI0NjEsImV4cCI6MTY0NzMzNjQzMjA2MX0.BSPHY9r2C6_spz1HOeGDhZPrppNtVYXQLokem30aQlMr6H96ARwbXxIumSwDE70bCoAHc9G0NcOgjglyAqbi0Nazg3Q5RwcNmQ2F68lpp69OU_YReZ7oxpFYjbi-kBp3RUX-u7WFRMr-0JCNq3oz1ajL4-32rI2JgXda25gNgGL4tVEnKz5j1YmcfwOWCV_W_YERnMxH0F2BGKYrbA7rleEZzVzRS_GkYI69eAknN3HoalbHlSSUzq295am56mpLmtm6ObJASIdEuOcI4NfA5ksoOp9UV8toqZU27ROx1Ky_dnwlyhAXMyjawkR-GlPqKcdTRjGovRk2bh1Qw_9Xh5NmQhkL4LgASLmToRGnslEO-s5kaULE4eM13gnp0hUvoMzZ_HnCIQGzqq2kQQbUDUmIcG0swD8YYD2feIdUMqu_cuoQCeXCvqItUc96om0iy6YAQd8j2-_6Yv1aBBdA0SCEFWANeqiwmGdidh-49InEI8td8KRo0I9pvu--5GSg45an7VmrwlzzRtDJJd_2zXXQ6BlpGl38EJKm6m67FrXARH2Cn82cOrLB9SI5Yxro-qSFG_xryiyA8CthapAueM39RQKN0oaiv4zLk9DctTLsh-a8xZZABODiNMExIPI8N5sSFQqC7sIpJqTYLmpDmKxiLOR3apCjb4Nz3NhGuVw"
