From: Svein Seldal <sveinse@seldal.com>
Subject: i2c-tools userspace tools
Date: Thu, 14 Apr 2016 23:55:22 +0200
Message-ID: <571011CA.7090307@seldal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:52261 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcDNVzZ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 17:55:25 -0400
Received: from 156.92-221-160.customer.lyse.net ([92.221.160.156]:54616 helo=[10.5.5.100])
	by smtp.domeneshop.no with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <sveinse@seldal.com>)
	id 1aqpER-00039e-Jd
	for linux-i2c@vger.kernel.org; Thu, 14 Apr 2016 23:55:23 +0200
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi

Is this the right list to discuss the i2c-tools user space software? If 
not, please disregard this email.

I have noticed that I can't seem to be able to use these tools out of 
box for very many i2c devices, as the i2cget/i2cset isn't using a very 
common protocol that these chips use.

E.g. the protocol for byte/word read (which is also found in the SMBUS 
spec) is:

START - WR:SLAVE - DADR - START - RD:SLAVE - DATA - STOP

 From what I have tested, it seems "i2cget BUS SLAVE DADR" does the 
following

START - WR:SLAVE - DADR - START - RD:SLAVE - DADR - DATA - STOP

It contains an extra read DADR byte, which is the slot where the actual 
data is being returned.

(My workaround is to run "i2cset BUS SLAVE CMD; i2cget BUS SLAVE")

Is this something that patches will be accepted for?


Best regards,
sveinse
