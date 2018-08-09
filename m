From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Date: Thu, 9 Aug 2018 12:51:40 +0300
Message-ID: <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
References: <20180809091558.4317-1-hdegoede@redhat.com> <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com> <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:

>> I've applied the v4 of this patch and I don't think there are any
>> changes from it here.
>
>
> Correct, there were only changes to the 4th patch in the series.
>
>> As for the rest of the series I'll wait from comments from Wolfram and
>> the other reviewers.
>
>
> Ok, note if you've taken patch 1 you may also want to take patch 3 which
> is an ACPI code cleanup made possible by patch 1 and otherwise is
> unrelated.

I'm under impression Rafael is going to take entire series (at least
for patch 4 I'm expecting to give an Ack).

-- 
With Best Regards,
Andy Shevchenko
