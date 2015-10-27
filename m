From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [RESEND PATCH 1/3] i2c: added FUNC flag for unsupported clock
 stretching
Date: Tue, 27 Oct 2015 19:14:21 +0000
Message-ID: <615ec5b262ca9c6e1e6e783fd4651c18@rainloop.corna.info>
References: <20151020153511.GI5379@katana>
 <1442410323-9833-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:49155 "EHLO
	6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965053AbbJ0TX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Oct 2015 15:23:29 -0400
Received: from mail645.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id D6956FFC07D
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2015 20:14:23 +0100 (CET)
In-Reply-To: <20151020153511.GI5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-i2c@vger.kernel.org

October 20 2015 5:35 PM, "Wolfram Sang" <wsa@the-dreams.de> wrote:
> On Wed, Sep 16, 2015 at 03:32:01PM +0200, Nicola Corna wrote:
> 
>> Added I2C_FUNC_NO_CLK_STRETCH, to be used when clock stretching is not
>> supported.
>> 
>> Signed-off-by: Nicola Corna <nicola@corna.info>
> 
> I think this should be rather a quirk than a functionality, i.e.
> I2C_AQ_NO_CLK_STRETCH. Agree?
> 
I didn't know about these quirks, thanks. I'll update the patches, please review them.

Nicola Corna
>> ---
>> Documentation/i2c/functionality | 1 +
>> include/uapi/linux/i2c.h | 1 +
>> 2 files changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
>> index 4aae8ed..f53807e 100644
>> --- a/Documentation/i2c/functionality
>> +++ b/Documentation/i2c/functionality
>> @@ -21,6 +21,7 @@ For the most up-to-date list of functionality constants, please check
>> I2C_M_REV_DIR_ADDR and I2C_M_NO_RD_ACK
>> flags (which modify the I2C protocol!)
>> I2C_FUNC_NOSTART Can skip repeated start sequence
>> + I2C_FUNC_NO_CLK_STRETCH Does NOT support clock stretching
>> I2C_FUNC_SMBUS_QUICK Handles the SMBus write_quick command
>> I2C_FUNC_SMBUS_READ_BYTE Handles the SMBus read_byte command
>> I2C_FUNC_SMBUS_WRITE_BYTE Handles the SMBus write_byte command
>> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
>> index b0a7dd6..59e4b43 100644
>> --- a/include/uapi/linux/i2c.h
>> +++ b/include/uapi/linux/i2c.h
>> @@ -88,6 +88,7 @@ struct i2c_msg {
>> #define I2C_FUNC_SMBUS_PEC 0x00000008
>> #define I2C_FUNC_NOSTART 0x00000010 /* I2C_M_NOSTART */
>> #define I2C_FUNC_SLAVE 0x00000020
>> +#define I2C_FUNC_NO_CLK_STRETCH 0x00000040 /* No check for SCL low */
>> #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL 0x00008000 /* SMBus 2.0 */
>> #define I2C_FUNC_SMBUS_QUICK 0x00010000
>> #define I2C_FUNC_SMBUS_READ_BYTE 0x00020000
>> --
>> 2.5.1
