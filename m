From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Fri, 3 Jun 2016 10:24:56 +0200
Message-ID: <57513ED8.6000703@metafoo.de>
References: <1460992811.8946.22.camel@linux.intel.com>
 <5714FCBE.3060009@metafoo.de> <20160419124028.GF1725@lahna.fi.intel.com>
 <57162C4E.9090904@metafoo.de> <20160419131631.GG1725@lahna.fi.intel.com>
 <5716333D.1040106@metafoo.de> <20160419144027.GH1725@lahna.fi.intel.com>
 <20160424201437.GA2123@katana> <20160425072553.GK1725@lahna.fi.intel.com>
 <20160425073940.GD1541@katana> <20160425074126.GL1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160425074126.GL1725@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
List-Id: linux-i2c@vger.kernel.org

On 04/25/2016 09:41 AM, Mika Westerberg wrote:
> On Mon, Apr 25, 2016 at 09:39:41AM +0200, Wolfram Sang wrote:
>> On Mon, Apr 25, 2016 at 10:25:53AM +0300, Mika Westerberg wrote:
>>> On Sun, Apr 24, 2016 at 10:14:37PM +0200, Wolfram Sang wrote:
>>>>
>>>>> The above should work with both DT and ACPI so I'm OK with the current
>>>>> patch. We can add ACPI parts later when needed.
>>>>
>>>> Just to make sure, I read this as an ack for the original patch?
>>>
>>> Yes :)
>>
>> Thanks! Could you use the formal tag for that in the future please?
>> Patchwork automatically collects them and that saves me some work. (I
>> even have a keyboard macro for that and use it a lot)
> 
> Sure, sorry about that.
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Wolfram,

It looks like everybody was OK now with this patch, but it got lost somehow.
Should it be resent, or can you still pick it up from patchwork?

Thanks,
- Lars
