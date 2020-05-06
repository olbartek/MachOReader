import XCTest

import MachOReaderTests

var tests = [XCTestCaseEntry]()
tests += MachOReaderTests.allTests()
XCTMain(tests)
