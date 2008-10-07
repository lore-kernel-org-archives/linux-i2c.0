From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Tue, 7 Oct 2008 22:00:10 +0200
Message-ID: <20081007220010.1ac00ad1@hyperion.delvare>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local>
	<20080926092846.63ac885a@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
	<20080930092458.1c40edce@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C903402@CLUSTEREX.corporate.local>
	<20081003152123.489cd10c@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C903870@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <6601CF63C167F44A9A9E97E41EE4B16C903870-5t2rvgrEeX4DiO1sSoDvakTPyXqlV3SlZkel5v8DVj8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Prakash,

On Tue, 7 Oct 2008 11:19:46 -0400, Mortha, Prakash wrote:
> Please find attached the patches I have generated using quilt. Hopefully
> this should meet the requirements.  (Please bear with me if this doesn't
> meet the requirements, as this is my first time to generate a official
> patch).

The patches meet the technical requirements, in that I was able to
apply them. However they are missing a proper subject and description,
as well as your Signed-off-by line. Again, please see section 12 (Sign
your work) of Documentation/SubmittingPatches for what it means.

For example, the header of your first patch could be something like:

* * * * *
From: Prakash Mortha <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: i2c: Restore i2c_smbus_process_call function

Restore the i2c_smbus_process_call() as one driver (for the
Micronas MAP5401) will need it soon.
* * * * *

And then would come your Signed-off-by line. For your first
contribution, I want to make it easy for you and I'll be adding the
subject and description myself, but I _need_ your Signed-off-by line
before I can push both patches upstream.

> Thank you once again for your valuable inputs/comments. I tried
> implementing all your suggestions, except for the following:
> 
> 1. I didn't modify the Documentation/i2c/smbus-protocol, as this
> document is already talking about the new function that I have worked
> on.

But it doesn't mention the name of the function implementing the
transaction. That's what I wanted you to add. But that's OK, I added it
myself. I also updated Documentation/i2c/writing-clients, which was
claiming that function i2c_smbus_process_call() had been removed from
the kernel.

> 2. I had to implicitly have the following lines of code in i2c-viapro.c,
> because for process call functionality the bus driver has to be in write
> mode initially and then has to switch to Read mode. (With out these
> implicit lines of code i2c-viapro bus driver is returning immediately
> after write call as per the existing control flow.)
> 	if ( size == VT596_PROC_CALL)
> 	              read_write = I2C_SMBUS_READ;
> Please provide your suggestion if I could do it in a better way.

I was wondering about this. The "process call" is special in that it
doesn't have a read variant and a write variant. Instead, it is a
transaction combining write and read. So I was wondering if the
direction bit had any effect on the VIA chip. According to your tests,
it must be handled as a write operation at the device level. So, your
implementation is correct.

I had to fix a number of whitespace issues in the second patch. Next
time, I suggest that you run scripts/checkpatch.pl on your patch, it
will tell you about that kind of minor problems so that you can fix
them before sending the patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
