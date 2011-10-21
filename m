From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] i2c: boilerplate function for byte swapped smbus_write/read_word_data
Date: Fri, 21 Oct 2011 11:16:21 +0100
Message-ID: <4EA14675.5070505@cam.ac.uk>
References: <20111009094118.44b616bf@endymion.delvare> <1318237663-13937-2-git-send-email-jic23@cam.ac.uk> <20111010135014.72598737@endymion.delvare> <20111011134906.60a8c284@endymion.delvare> <4E945F06.6050308@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E945F06.6050308-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <public-jic23-KWPb1pKIrIJaa/9Udqfwiw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>
Cc: Jean Delvare <public-khali-PUYAD+kWke1g9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org, public-ben-linux-elnMNo+KYs3YtjvyW6yDsg-wOFGN7rlS/M9smdsby/KFg@public.gmane.org, public-Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 10/11/11 16:21, Jonathan Cameron wrote:
> On 10/11/11 12:49, Jean Delvare wrote:
>> On Mon, 10 Oct 2011 13:50:14 +0200, Jean Delvare wrote:
>>> On Mon, 10 Oct 2011 10:07:43 +0100, Jonathan Cameron wrote:
>>>> Reimplemented at least 17 times discounting error mangling cases
>>>> where it could be used.
>>>>
>>>> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>>> ---
>>>>  Documentation/i2c/smbus-protocol |    8 ++++++++
>>>>  include/linux/i2c.h              |   17 +++++++++++++++++
>>>>  2 files changed, 25 insertions(+), 0 deletions(-)
>>>
>>> Applied, thanks.
>>
>> BTW... I have a patch ready converting all concerned hwmon drivers to
>> use the new functions. I would appreciate if you could take care of all
>> other drivers.
>>
>> Thanks,
> Will do. Have IIO patch queued locally.  Will get the others covered shortly.
Jean,

Sorry forgot to cc you on the first few patches I sent out using this.
So for reference (and anyone else who cares).

IIO I'll deal with when it merges (patch has been posted for a couple of weeks).
v4l sent out (5 drivers)
input sent out patch (only one user)
power sent out patch (only one user)

All pretty trivial cases.

Jonathan
