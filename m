From: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-tools: add Android.mk
Date: Mon, 16 Mar 2015 10:30:38 +0100
Message-ID: <CA+TH9Vn_iD5+LPUBLY1awJiNVTvsxq4TkXHUJuE_9tLuJsmvAw@mail.gmail.com>
References: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA@mail.gmail.com>
 <20150316101626.2c7a02be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150316101626.2c7a02be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Jean Delvare,

The Android build system requires an Android.mk into the root dir of a
package. Android simply doesn't use recursive makefile.

So if you want to drop i2c-tools into the android source tree to
having it compiled by the Android build system, you should add an
Android.mk manually.

Probably, the other projects you mention are compiled externelly from
the Android build system with an external toolchain, so calling make
with the right options is not a problem.

I think that all projects potentially interesting in the Android world
should adopt an Android.mk to be easily buildable into the Android
build system.

Sincerely, Angelo.

2015-03-16 10:16 GMT+01:00 Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>:
> Hi Angelo,
>
> On Fri, 27 Feb 2015 22:05:12 +0100, Angelo Compagnucci wrote:
>> This patch adds an Android.mk to compile i2c-tools under Android.
>>
>> Hope this helps!
>
> I have to say I don't know what to do with this.
>
> For one thing, I don't really understand why Android needs a separate
> build mechanism when all other Linux and BSD incarnations seem to be
> fine with the standard Makefile. GNU make certainly runs on Android,
> right? And you would typically cross-compile for Android anyway. Also I
> have not seen an Android.mk file in any other project I'm working on,
> and I can't see why i2c-tools would be special in this respect.
>
> For another, the current build mechanism is a modular one where the
> main Makefile includes Module.mk files present in the different
> subdirectories. I like this design and having a single Android.mk file
> at the root of the project is inconsistent and breaks that design.
>
> As a summary I don't see why anything special is needed for Android,
> but if something like that is really needed then it should respect the
> existing modular design.
>
> Now if anyone has a more educated view on this than I do, please speak
> up. Android is really not my thing (as a developer, I mean.)
>
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
