From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: [PATCH] i2c: do not use device name after device_unregister
Date: Wed, 13 Jan 2010 14:38:04 +0400
Message-ID: <1a297b361001130238o524674a4j1c197fd694637d95@mail.gmail.com>
References: <1263332203-5542-1-git-send-email-cascardo@holoscopio.com>
	 <20100113112515.3c73ceee@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932113Ab0AMKiQ@vger.kernel.org>
In-Reply-To: <20100113112515.3c73ceee@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 13, 2010 at 2:25 PM, Jean Delvare <khali@linux-fr.org> wrot=
e:
> Hi Thadeu,
>
> On Tue, 12 Jan 2010 19:36:43 -0200, Thadeu Lima de Souza Cascardo wro=
te:
>> dev_dbg outputs dev_name, which is released with device_unregister. =
This bug
>> resulted in output like this:
>>
>> [ 7860.470713] i2c Xy2=EF=BF=BD0: adapter [SMBus I801 adapter at 188=
0] unregistered
>>
>> The right output would be:
>> [ =C2=A0 60.639233] i2c i2c-0: adapter [SMBus I801 adapter at 1880] =
unregistered
>
> I can't reproduce this bug. Do you have a specific memory poisoning
> option enabled by any chance? And which kernel version are you runnin=
g
> exactly?


Same thing happens here with 2.6.30.5:

[11984.257365] i2c-adapter kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk=EF=BF=BD[=EF=
=BF=BDt=EF=BF=BD=EF=BF=BD
 : adapter [SAA716x I2C Core 0] unregistered

Regards,
Manu
