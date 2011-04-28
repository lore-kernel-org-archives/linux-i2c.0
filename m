From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/3] i2c: append hardware lock with bus lock
Date: Thu, 28 Apr 2011 22:48:02 +0800
Message-ID: <BANLkTi=YeqxF_eu2Q=cy6oAFfyTrzAH6VA@mail.gmail.com>
References: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com>
	<20110428102212.2d8d607c@endymion.delvare>
	<BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com>
	<20110428161625.5eaacb85@endymion.delvare>
	<20110428143724.GQ17290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110428143724.GQ17290@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 28, 2011 at 10:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 28, 2011 at 04:16:25PM +0200, Jean Delvare wrote:
>> Are you suggesting that the hardware lock wouldn't mind being taken
>> twice by the AP side? If it is the case, then indeed the software mu=
tex
>> is still needed to prevent it from happening.
>>
>> That being said... I guess that avoiding a priority inversion is a g=
ood
>> enough reason to always take the rt_mutex, regardless of the hardwar=
e
>> lock implementation.
>>
>> So, this patch is
>>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
>>
>> I guess it makes more sense for me to let Ben apply it, as the other
>> two patches in the series are for him too. This will avoid a depende=
ncy
>> between our trees.
>
> Only change I'd suggest is passing adapter to the hardware_lock/unloc=
k
> methods. =A0Having no arguments what so ever in generic code for this=
 kind
> of stuff looks rather strange and limiting.
>

OK. I'll update it.
