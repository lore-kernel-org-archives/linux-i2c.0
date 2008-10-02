From: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Thu, 2 Oct 2008 09:52:42 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C90343A@CLUSTEREX.corporate.local>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local><20080926092846.63ac885a@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
	<20080930092458.1c40edce@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

In the patch I sent to you, I used the approach where I need to send
MSByte first and then LSByte for I2C_SMBUS_PROC_CALL case.

If we need to keep this in accordance with other cases, We need to
interchange the below lines: ( in i2c-viapro.patch)
		outb_p((data->word & 0xff00) >> 8, SMBHSTDAT0);
		outb_p(data->word & 0xff, SMBHSTDAT1);
Thanks,
Prakash



-----Original Message-----
From: Mortha, Prakash 
Sent: Wednesday, October 01, 2008 8:09 PM
To: 'Jean Delvare'
Cc: Linux I2C
Subject: RE: Question about vt82c596 SMBus driver (Via I2c Bus driver)


Hi Jean,

Thank you very much for your corrections/advice.

Please find attached the patch files for i2c-viapro.c and i2c-core.c
files for supporting I2C_SMBUS_PROC_CALL. 

Please provide your comments.

(FYI, in my test environment I had to swap MSB and LSB bytes while
dealing with I2C_SMBUS_WORD_DATA, I2C_SMBUS_PROC_CALL and
VT596_WORD_DATA/VT596_PROC_CALL, but I didn't do the swap while
generating the patch file to keep the earlier design in-tact.)

Thank you,
Prakash



-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Tuesday, September 30, 2008 3:25 AM
To: Mortha, Prakash
Cc: Linux I2C
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)

Hi Prakash,

On Mon, 29 Sep 2008 11:49:30 -0400, Mortha, Prakash wrote:
> I found the reason why drivers/i2c/busses/i2c-viapro.c is not
supporting
> I2C_SMBUS_PROC_CALL. The reason I found is as per the data sheet of
Via
> Chip set the "SMBus Command Protocol field" should be set as bits 4-2
in
> "SMBus Host Control" register. But in the function 
> 
>       static int vt596_transaction(u8 size)
> 
> we are setting the "SMBus Command Protocol field" as bits 2-0:
> 
> outb_p(0x40 | size, SMBHSTCNT); (Line 134 in
> drivers/i2c/busses/i2c-viapro.c)

"size" is supposed to be already shifted at this point. If you look at
the constants:

#define VT596_QUICK		0x00
#define VT596_BYTE		0x04
#define VT596_BYTE_DATA		0x08
#define VT596_WORD_DATA		0x0C
#define VT596_BLOCK_DATA	0x14
#define VT596_I2C_BLOCK_DATA	0x34

They really are (0x0 << 2), (0x1 << 2), (0x2 <<2) etc. Maybe we should
write them that way to make it clearer.

> When I changed the statement to shift the Protocol field by 2 bits
> I2C_SMBUS_PROC_CALL worked and REPEATED START is being generated as
per
> SMBus Process call specification.
> 
> outb_p(0x40 | (size<<2), SMBHSTCNT);
> 
>  
> 
> Could you please confirm whether the reason I found is valid or not?

No, it's not. Your change just happens to work by accident in your
specific case. But the original code is correct as it is. Please
remember that this driver has been used by thousands of people for many
years now, so it's rather unlikely that the common code paths have such
a huge bug.

> Please find attached the patch I wrote. The Via Motherboard I am using
> is EPIA Ex 1500G.  

Please use "diff -u" to generate the patch, otherwise it's rather
difficult to read. But your current patch doesn't look correct anyway.
The first thing to do is to introduce a new constant for process call
transactions:

#define VT596_PROC_CALL		0x10

Then in vt596_access() you must set size = VT596_PROC_CALL for the
I2C_SMBUS_PROC_CALL case. This is currently missing in your code (you
do not set "size" at all!) and that's the reason why it didn't work.

Also, you must add I2C_SMBUS_PROC_CALL to vt596_func(), otherwise users
do not know that this protocol is supported.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
