From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
 	functions and data
Date: Wed, 10 Feb 2010 15:45:30 +0100
Message-ID: <4B72C68A.8020300@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com> 	<1264685141-26391-2-git-send-email-wg@grandegger.com> <fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com> 	<4B7285D5.9060008@grandegger.com> <20100210213203.48a9105e.sfr@canb.auug.org.au> 	<4B729043.9080303@grandegger.com> <fa686aa41002100614l76bff396ved847c0b0a4c71ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa41002100614l76bff396ved847c0b0a4c71ff-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Wed, Feb 10, 2010 at 3:53 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>> Stephen Rothwell wrote:
>>> Hi Wolfgang,
>>>
>>> On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>>>>> __devinitdata goes at the end, immediately before the '='.  Ditto
>>>>> throughout the file.
>>>> This made a difference and revealed section mismatches. "const" seems to
>>>> be incompatible with "__devinitdata".
>>> Maybe try no "const" and "__devinitconst" (I am not sure if both will
>>> work).
>> Yes, that works, even together with "const". To avoid rolling out the
>> whole patch series again, I can prepare a follow-up patch fixing this issue.
> 
> Nah, just resend this one patch.

Even if it break the following patches? Will resend v7 in a second.

Wolfgang.
