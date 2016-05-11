From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 11 May 2016 16:15:44 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A94FB736C@ORSMSX101.amr.corp.intel.com>
References: <20160511093452.5bc2614c@endymion>
 <20160511104322.60521365@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38226 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbcEKQPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 12:15:48 -0400
In-Reply-To: <20160511104322.60521365@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi Jean,

> On Wed, 11 May 2016 09:34:52 +0200, Jean Delvare wrote:
> > In commit 062737fb6d90 you added support for the Intel Lynx Point PCH
> > to the i2c-i801 driver. I happen to have a machine with this chipset
> > since a few weeks, and found that the i2c-i801 driver doesn't work
> > properly on it. Specifically, the eeprom driver return 0xff for all
> > EEPROM bytes. The at24 driver fails too, with a timeout.
> >
> > After some testing using i2cdetect, i2cdump and i2cget, I found that
> > some I2C transactions work (SMBUS_QUICK, SMBUS_READ_BYTE,
> > SMBUS_READ_BYTE_DATA, SMBUS_READ_WORD_DATA,
> SMBUS_READ_BLOCK_DATA),
> > however others do not (SMBUS_WRITE_BYTE, SMBUS_READ_I2C_BLOCK.) I
> > can't easily test other transaction types as all I have on the SMBus
> > are SPD EEPROMs on my memory modules.
> >
> > Did you test the i2c-i801 driver on an actual Lynx Point PCH chipset?
> > Or did you only add the PCI ID of the device, assuming it would work?

I tested on an Intel system with Lynx Point and saw everything working, consistent with what you're seeing on the SUSE system.

Regards,
Seth
