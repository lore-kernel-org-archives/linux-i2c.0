From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Date: Thu, 9 Aug 2018 13:36:50 +0200
Message-ID: <9169f2a6-7835-0472-9b08-320106125716@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
 <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
 <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
 <f2f9289d-0adb-e165-a23e-696fe985fda4@redhat.com>
 <CAJZ5v0hvfR=m5GXhSS4Q7DYFS9+BA+EAt9oHOYdxMU-J78dtwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hvfR=m5GXhSS4Q7DYFS9+BA+EAt9oHOYdxMU-J78dtwQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 09-08-18 11:59, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 11:58 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 09-08-18 11:51, Andy Shevchenko wrote:
>>>
>>> On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>>>>> wrote:
>>>
>>>
>>>>> I've applied the v4 of this patch and I don't think there are any
>>>>> changes from it here.
>>>>
>>>>
>>>>
>>>> Correct, there were only changes to the 4th patch in the series.
>>>>
>>>>> As for the rest of the series I'll wait from comments from Wolfram and
>>>>> the other reviewers.
>>>>
>>>>
>>>>
>>>> Ok, note if you've taken patch 1 you may also want to take patch 3 which
>>>> is an ACPI code cleanup made possible by patch 1 and otherwise is
>>>> unrelated.
>>>
>>>
>>> I'm under impression Rafael is going to take entire series (at least
>>> for patch 4 I'm expecting to give an Ack).
>>
>>
>> As I mentioned in the coverletter, my idea was to have Rafael take
>> patches 1-3 and then merge the 4th patch through the platform/x86
>> tree. There are only runtime dependencies between the 2 parts and
>> merging them independently should not cause any issues.
> 
> I can apply the 4th one too if it is ACKed by everyone with a vested interest.

That works for me, note I'm about to send out a v6 (with only changes to
the 4th patch), so hold of a bit with merging this please.

Andy does your ack for the 4th patch mean you're ok with Rafael merging
this?

Regards,

Hans
