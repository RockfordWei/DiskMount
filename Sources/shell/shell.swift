import PerfectLib
import Foundation
public func shell(_ cmd: String) throws -> String {
  let envs = [("PATH", "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")]
  let proc = try SysProcess("/bin/bash", 
    args: ["-c", cmd], env: envs)
  var ary = [UInt8]()
  while true {
      do {
          guard let s = try proc.stdout?.readSomeBytes(count: 1024), s.count > 0 else {
              break
          }
          ary.append(contentsOf: s)
      } catch PerfectLib.PerfectError.fileError(let code, _) {
          if code != EINTR {
              break
          }
      }
  }
  let ret = UTF8Encoding.encode(bytes: ary)
  let res = try proc.wait(hang: true)
  if res != 0 {
        let s = try proc.stderr?.readString()
        throw  PerfectError.systemError(Int32(res), s!)
    }
    return ret
}
