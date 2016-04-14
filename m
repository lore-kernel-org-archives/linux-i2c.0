From: Daniel Walker <danielwa@cisco.com>
Subject: i2c device hangs the whole bus, recovery ?
Date: Thu, 14 Apr 2016 16:34:29 -0700
Message-ID: <57102905.7080904@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:56636 "EHLO
	alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcDNXoK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 19:44:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>, "Anil Veliyankara Madam (aveliyan)" <aveliyan@cisco.com>, "Perry Li (chuangli)" <chuangli@cisco.com>


Hi all,

We have a pca954x MUX and connected to this is some devices. We have one 
device connected to the MUX which goes bad, and when we try to 
communicate with the bad device (we don't know it's bad yet) , it causes 
one of the i2c lines to go low and makes it impossible to connect with 
any of the other devices on the bus.

I don't know how common this type of situation is, but I thought I would 
ask here how people would recover from this condition ? Is there a 
standard way to do it, or is the standard way to reboot the machine ?

I think ideally I would like to be able to detect that something is 
wrong, and black list the device, and recover if possible.

Any suggestions appreciated,

Daniel
