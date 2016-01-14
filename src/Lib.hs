module Lib where

import Data.Attoparsec.ByteString
import qualified Data.ByteString as BS

import Prelude hiding (take)

someFunc :: IO ()
someFunc = putStrLn "someFunc"


-- (PktHdr {hdrSeconds = 1338882754, hdrUseconds = 996790, hdrCaptureLength = 54, hdrWireLength = 54},"\NUL\DC2\207\229T\160\NUL\US<#\219\211\b\NULE\NUL\NUL(J\166@\NUL@\ACKX\235\192\168\n\226\192\168\v\fL\251\NUL\ETB\231\202\248X&\DC3E\222P\DC1@\199>\166\NUL\NUL")

-- src mac 6 bytes
-- dest mac 6 bytes
-- type 2 bytes
-- data 46 to 1500 bytes

data EthernetFrame = EthernetFrame
    { etherSrc  :: BS.ByteString
    , etherDest :: BS.ByteString
    , etherType :: BS.ByteString
    , etherData :: BS.ByteString
    } deriving (Eq, Show)

data TCPSegment = TCPSegment
    { tcpSegSrcPort :: BS.ByteString
    , tcpSegDestPort :: BS.ByteString
    , tcpSegSeqNum :: BS.ByteString
    , tcpSegAckNum :: BS.ByteString
    , tcpSegHdrLen :: BS.ByteString -- 4 bits
    , tcpSegFlags :: [BS.ByteString]
    , tcpSegChkSum :: BS.ByteString
    , tcpSegUrgentPtr :: BS.ByteString
    , tcpSegOptions :: BS.ByteString
    , tcpSegData :: BS.ByteString
    } deriving (Eq, Show)


parseEtherFrame :: Parser EthernetFrame
parseEtherFrame = EthernetFrame
    <$> take 6
    <*> take 6
    <*> take 2
    <*> takeByteString

parseTCPSegment :: Parser TCPSegment
