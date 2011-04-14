From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Thu, 14 Apr 2011 13:42:19 +0200
Message-ID: <4DA6DD9B.40208@gmx.de>
References: <4DA4250A.3060907@fuckner.net>	<20110412132611.045ace21@endymion.delvare>	<4DA44B05.906@fuckner.net>	<20110412155345.4644e51c@endymion.delvare>	<4DA53F22.5020105@gmx.de> <20110413103952.68bdb6fa@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110413103952.68bdb6fa-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> On Wed, 13 Apr 2011 08:13:54 +0200, Michael Lawnick wrote:
>> I would expect a
>> #> echo "<deviceName> 0x70" > /sys/bus/i2c/devices/i2c-0/new_device
>> to span new buses, their numbers taken by random, even without platform
>> data (not tried by myself yet, but will have to do it soon).
> 
> Hmm, you're right, my memory that we has made platform data mandatory
> was wrong, sorry.
> 
>> The challenge will be to detect which of the 8 supported devices (
>> pca_9540, pca_9542, pca_9543, pca_9544, pca_9545, pca_9546, pca_9547,
>> pca_9548) is actually to be used.
> 
> In Michael's case it is irrelevant anyway, as the information he found
> meanwhile clearly indicates that bus multiplexing is achieved by GPIOs
> (most certainly on the ICH10) and not an PCA954x chip. The chip at 0x70
> is probably the Intel 5500 IOH.
> 
Well, if he implements a multiplexer code for it, he is done :-)

-- 
KR
Michael
