From: Phil Reid <preid@electromag.com.au>
Subject: i2c devices and regulators
Date: Thu, 12 Nov 2015 13:28:59 +0800
Message-ID: <5644239B.1050904@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:34836 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751463AbbKLFfv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 00:35:51 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

G'day All,

Please direct me to the appropriate message list if this is the wrong place.

Is there a generic way to apply a regulator dependencies on an i2c 
device via the device tree.

Situation is with our hardware a number of slave i2c devices attached 
via one of the following example:
- eg. TCA6408 GPIO with Vccp on separate regulator to i2c bus Vcci.
   These device hold reset until Vccp reaches threshold.
- I2c isolators eg. ADUM1250 isolator that requires power one both
   sides before communication starts.

Is there a generic mechanism to apply a regulator supply to a i2c 
device? Or should this be part of the individual device driver?

Similar situation occur with i2c multiplexers. It may be required to 
power up a slave side regulator before switch to a but that is 
currently isolated.

Or is there a better method of controlling these dependencies that I've 
missed?


-- 
Regards
Phil Reid
