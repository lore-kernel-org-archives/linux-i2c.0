From: Michael Klein <michael.klein-m4xtk+dBUWCZFsvuydyz1KhivhuVJJ3m@public.gmane.org>
Subject: Patch: Darwin (Mac OS X) support for decode-dimms
Date: Thu, 14 May 2009 23:15:08 +0200 (CEST)
Message-ID: <alpine.OSX.1.00.0905142254120.24797__49322.4298967563$1242374033$gmane$org@fjelljo.puffin.lb.shuttle.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-974072874-1242335708=:24797"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--0-974072874-1242335708=:24797
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Hi!

Here's a small patch for the decode-dimms script to make it work on OS 
X.  Instead of device nodes, the EEPROM content can be read with the 
ioreg(8) command there.

Tested on a G5 iMac and a G4 PowerBook, both running OS X 10.4.11.

Regards,
Michael

-- 
Message composed with
VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Jan 10 2009 20:59:41)
--0-974072874-1242335708=:24797
X-Content-Type: TEXT/PLAIN; charset=US-ASCII; name=decode-dimms+darwin-support.diff
X-Content-Transfer-Encoding: BASE64
Content-ID: <alpine.OSX.1.00.0905142315080.24797-j5vrdnS1lu2bjG2T50FRYJkWy+7J3LPUqGK+G5UkneY@public.gmane.org>
Content-Description: 
X-Content-Disposition: attachment; filename=decode-dimms+darwin-support.diff
Content-Type: TEXT/PLAIN

The following attachment was sent,
but NOT saved in the Fcc copy:
    A Text/PLAIN (Name="decode-dimms+darwin-support.diff") segment of about 2,980 bytes.

--0-974072874-1242335708=:24797--
