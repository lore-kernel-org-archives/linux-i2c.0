From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Thu, 07 May 2009 08:36:50 +0200
Message-ID: <4A028182.3040107@grandegger.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>	<1241640919-4650-9-git-send-email-wd@denx.de> 	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com> 	<20090506221908.3927583420E8@gemini.denx.de>	<fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com> <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Wed, May 6, 2009 at 4:51 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org> wrote:
>>> Dear Grant Likely,
>>>
>>> In message <fa686aa40905061401k319313c5q89fd3e245c30808f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> you wrote:
>>>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org> wrote:
>>>>> From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>>>>>
>>>>> - Enabled I2C interrupts on MPC5121.
>>>>> - Updated Kconfig for i2c-mpc driver.
>>>> I think this workaround belongs in the driver itself.
>>> Sorry, I don't get it. Which workaround? What exactly should I change?
>> Sorry, I misread the patch.  Never mind.
> 
> Actually, on 3rd reading, I think my first impression was correct
> (even if I was wrong about it being a workaround).  This code in
> mpc512x_init_i2c() is only relevant for i2c busses (it isn't shared
> with any other drivers).  Therefore, it belongs with the i2c bus
> itself.  It does not belong in platform code.

Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
setting for the MPC512x, which has been merged recently (see commit id
f2bd5efe).

Wolfgang.
