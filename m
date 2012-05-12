From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V1 2/2] i2c: tegra: notify transfer-complete after clearing
 status.
Date: Sat, 12 May 2012 19:14:18 +0530
Message-ID: <4FAE6932.7070605@nvidia.com>
References: <1336373179-12739-1-git-send-email-ldewangan@nvidia.com> <1336373179-12739-3-git-send-email-ldewangan@nvidia.com> <20120512130756.GI20673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120512130756.GI20673@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 12 May 2012 06:37 PM, Wolfram Sang wrote:
> * PGP Signed by an unknown key
>
> On Mon, May 07, 2012 at 12:16:19PM +0530, Laxman Dewangan wrote:
>> The notification of the transfer complete by calling complete()
>> should be done after clearing all interrupt status.
>> This may avoid the race condition of misconfigure the i2c controller
>> in multi-core environment.
> "may avoid" or "does avoid"? I.e. does it fix any bug that really
> occured? Then I'd add a stable tag.
>
> So far, applied to next.
"does avoid".
We had some of stability issue in long hour stress test with i2c and 
this is one the fix towards the stability issue. Most of fixes are 
already there in the mainline.
It is  fine to stable tag on this change.

>>   	if (status&  I2C_INT_PACKET_XFER_COMPLETE) {
>>   		BUG_ON(i2c_dev->msg_buf_remaining);
>>   		complete(&i2c_dev->msg_complete);
>>   	}
> Side note: If you see a way to handle the BUG invocations more
> gracefully, that would be appreciated.
>
Ok, I will work towards that.

Thanks,
Laxman
