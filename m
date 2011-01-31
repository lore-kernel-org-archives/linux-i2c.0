From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: add devicetree support
Date: Mon, 31 Jan 2011 14:35:31 -0800
Message-ID: <AANLkTini7Hx6dbTAKJKJy=NnC+LFcQuHEsayxwJJ78-+@mail.gmail.com>
References: <1296403013-6058-1-git-send-email-thomas@wytron.com.tw>
	<AANLkTi=5Uik+EwBRfYs_Pa77+qHngY03ezC63RC0WLQ8@mail.gmail.com>
	<AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Mon, Jan 31, 2011 at 12:09 AM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Sun, Jan 30, 2011 at 8:26 PM, H=E5vard Skinnemoen
> <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi,
>>
>> On Sun, Jan 30, 2011 at 7:56 AM, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> =
wrote:
>>> From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
>>>
>>> This patch is based on an earlier patch from Albert Herranz,
>>> http://git.infradead.org/users/herraa1/gc-linux-2.6.git/commit/
>>> 9854eb78607c641ab5ae85bcbe3c9d14ac113733
>>
>> That commit has a single-line description of which I don't understan=
d
>> a single word (unless "wii" is what I think it is, which seems
>> likely). Could you please explain how that commit relates to this
>> patch?
>
> The URL got wrapped. =A0Try this one (assuming my mailer doesn't wrap=
 it):
>
> http://git.infradead.org/users/herraa1/gc-linux-2.6.git/commit/9854eb=
78607c641ab5ae85bcbe3c9d14ac113733

Ok, that seems to be a _bit_ more related, but not that much. I'd
really prefer a patch description which can stand on its own.

>>> The dts binding is modified as Grant suggested. The of probing
>>> is merged inline instead of a separate file. It uses the newer
>>> of gpio probe.
>>
>> It seems like a terrible idea to merge firmware-specific code into t=
he
>> driver. Is there are reason why of-based platforms can't just pass t=
he
>> data they need in pdata like everyone else?
>
> Overall Thomas is doing the right thing here. =A0The driver data has =
to
> be decoded *somewhere*, but since that code is definitely
> driver-specific (as opposed to platform, subsystem, or arch specific)
> putting it into the driver is absolutely the right thing to do. =A0Qu=
ite
> a few drivers now do exactly this.

Ok, I'm convinced that this is the right thing to do.

> It is however generally a wise practice to limit the of-support code
> to a hook in the drivers probe hook, and as you point out, care must
> be taken to make sure both CONFIG_OF and !CONFIG_OF kernel builds
> work.
>
>>
>> Not saying that it necessarily _is_ a terrible idea, but I think the
>> reasoning behind it needs to be included in the patch description.
>
> Nah, he doesn't really need to defend this since it is a well
> established pattern. =A0device tree support is in core code now (see
> of_node an of_match_table in include/linux/device.h), and other
> drivers do exactly this.

Well, perhaps you're right, but I still think the patch description is
a bit on the thin side. In particular, terms like "as Grant suggested"
isn't very helpful for people like me who don't know what you
suggested (even though I'm sure it was a good suggestion).

I think the patch lacks a good description of what's being changed and
why. The references may be nice to have as a supplement to that, but
describing things entirely in terms of some unknown e-mail discussion
that happened earlier is not very helpful for people who want to
figure out what's going on a couple of months or years from now.

Havard
