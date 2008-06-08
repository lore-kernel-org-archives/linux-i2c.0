From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
 for i2c-i801
Date: Sun, 8 Jun 2008 20:18:28 +0200
Message-ID: <20080608201828.18483a17@hyperion.delvare>
References: <20080606124447.756f8262@eurotech-ltd.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080606124447.756f8262-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Amit Walambe <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Amit,

On Fri, 6 Jun 2008 12:44:47 +0100, Amit Walambe wrote:
> Hello Mark and Jean!

Mark is no longer involved in kernel driver development. I am adding
the i2c mailing list in Cc instead, in case others developers or users
are interested.

> We have a Pentium M board which was running into i2c issues at a
> customer site. They extensively use i2c to manipulate LEDs on the front
> panel of the enclosure. 
> We use i2c-regs utility and some times the read and write operations
> were failing with the following message : 
> write_smbus_register: Operation not permitted
> read_smbus_register: Operation not permitted
> (Attaching the script used to reproduce the failures and i2c-regs
> utility source code)

Out of curiosity, why are you using this proprietary utility instead of
the standard i2cget and i2cset programs?

> This is the relevant line from the lspci output : 
> 00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
> Controller (rev 02)

Which kernel is your customer using? There have been a number of
improvements done to the i2c-i801 driver over the last year. And what
motherboard is this? Please provide the output of i2cdetect for this
bus.

Is there a second master on the SMBus on the customer's system?


> Enabling debug in kernel produced following messages : 
> i801_smbus 0000:00:1f.3: Failed reset at end of transaction(01)
> i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> i801_smbus 0000:00:1f.3: Failed! (01)
> i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> i801_smbus 0000:00:1f.3: Failed! (01)
> i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> i801_smbus 0000:00:1f.3: Successfull!
> (I commented out 'Transaction ([pre]/[post])' debug prints as they were
> creating a little too much data)

I agree that these pre/post debug messages are very noisy and not
necessarily very interesting now that the driver development is done.
I'll post a patch removing them.

> The fix involved was to write a loop to wait for the final reset to go
> through. After that, we still see following messages, but atleast it is
> not failing over : 
> i801_smbus 0000:00:1f.3: SMBus busy (02).Resetting... 
> i801_smbus 0000:00:1f.3: Successfull! 
> i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> i801_smbus 0000:00:1f.3: Successfull!

Comparing this to the log above, I don't see any change. Resetting when
register value was 02 was already working. It's resetting when register
value was 01 that was failing, so that's what you need to check with
the patch applied.

> Secondly, the i2c-regs utility was failing with
> 'Operation not permitted' error, which was a bit misleading. It happens
> because i801_transaction returns -1 for all the failures and that value
> is taken up to the user level. So I have changed the return values to
> suit the cause better. This is also included in the same patch. 

We already have a fix pending for this problem:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-adapters-return-proper-error-codes.patch
It will be merged in kernel 2.6.27.

> Please let me know what you think.

First of all: please note that the kernel code uses tabs for
indentation, while your patch uses 4 spaces. You'll have to fix your
patch. Also remove the change of error codes, as we already have a
patch fixing them.

I am very worried by the code 01 which triggers the reset (which is
probably not the right thing to do, BTW.) The host should never be busy
when we start a transaction. If the problem happens frequently, this
strongly suggests that some other code is making use of the host
controller. This could for example be ACPI code. Please provide the
DSDT for this machine (in private.)

If something else is making use of the SMBus host then the i2c-i801
driver can't use it safely, no matter how you look at it. So my feeling
is that your patch, if it does anything, is not actually solving the
problem but only hiding it or making it less likely to happen.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
