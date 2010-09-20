From: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: RE: [PATCH v3] i2c: davinci: Fix race when setting up for TX
Date: Mon, 20 Sep 2010 05:40:51 +0100
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093ED5F50E@Cloud.RL.local>
References: <4C93BE5B.6090701@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <4C93BE5B.6090701-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Troy Kisky wrote:
> On 9/17/2010 6:09 AM, Sudhakar Rajashekhara wrote:
>> Hi,

Seems I didn't get Sudhakar's email.. I wonder why?

>> On Fri, Sep 17, 2010 at 08:32:11, Jon Povey wrote:
>>> Move the MDR load after DXR,IMR loads to avoid this race without
>>> locking.
>>
>> I remember I had some issues on OMAP-L138 with this fix, that's when
>> I reverted to configuring ICMDR before writing to DXR (Please see
>> here: https://patchwork.kernel.org/patch/75262/). I checked the BIOS
>> I2C driver code for OMAP-L138 and there also we are configuring MDR
>> before accessing DXR.

Ah :/

> How about killing the lines from commit
> c6c7c729a22bfeb8e63eafce48dbaeea20e68703
> -------------------------------
> /*
>  * First byte should be set here, not after interrupt,
>  * because transmit-data-ready interrupt can come before
>  * NACK-interrupt during sending of previous message and
>  * ICDXR may have wrong data
>  */
> if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
>         davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
> dev->buf_len--; }
> ----------------------
>
> and resetting the i2c upon a NAK interrupt (after the stop)
> to clear the bad fifo data?

I can't really comment on how valid that would be and can't easily test it.

However preloading DXR does save one interrupt on transmit so the whole operation is faster and more efficient.

Maybe v1 of my patch, with locking, is the best option?

--
Jon Povey
jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
