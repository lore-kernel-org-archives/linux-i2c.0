From: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Subject: Re: Questions about i2c_transfer() usage in timer context...
Date: Mon, 20 Feb 2012 14:19:49 +0100
Message-ID: <4F424875.5030600@peak-system.com>
References: <4F424440.300@peak-system.com>
 <20120220141112.1e633beb@endymion.delvare>
Reply-To: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120220141112.1e633beb-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Merci Jean,

Thx for the quick answer. I think this will help.

St=C3=A9phane

Le 20/02/2012 14:11, Jean Delvare a =C3=A9crit :
> Bonjour St=C3=A9phane,
>
> On Mon, 20 Feb 2012 14:01:52 +0100, Stephane Grosjean wrote:
>> I'm facing a deadlock regarding a timer callback which is only calli=
ng
>> i2c_transfer(), and I wonder if this comes from that call: I first
>> googled and found that i2c_transfer() may sleep (which is forbidden =
in
>> my timer callback) but when I have a look the beginning of the funct=
ion,
>> it starts to check if it is in any atomic context, before trying to
>> acquire  a lock...
>>
>> So I'm afraid I'm lost and I hope someone will be able to understand=
 to
>> that question: might i2c_transfer() be used in a timer callback or
>> should I handle my periodic call to i2c_tranfer() by means of a dela=
yed
>> work?
> Depends on the underlying I2C adapter driver. One of the sleep causes
> is indeed the acquisition of the mutex in i2c_transfer(). However the
> function then calls a driver specific callback function
> (adap->algo->master_xfer) which may or may not sleep too depending on
> the implementation. So if you want your code to be portable, you have=
 to
> assume that it may sleep, which means you indeed have to use a delaye=
d
> work.
>
> HTH,
