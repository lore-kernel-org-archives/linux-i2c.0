From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix regression when dynamic TAR update
 is disabled
Date: Fri, 10 Feb 2017 12:48:57 +0200
Message-ID: <d1db459e-59a4-72d8-e21c-bb44545f10e6@linux.intel.com>
References: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
 <1486670858.2133.436.camel@linux.intel.com>
 <1486676048.14478.4.camel@intel.com>
 <110f9081-ddba-82c2-6ba3-f92bc36d0bc3@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <110f9081-ddba-82c2-6ba3-f92bc36d0bc3@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, "De Marchi, Lucas" <lucas.demarchi@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "Nehal-Bakulchandra.Shah@amd.com" <Nehal-Bakulchandra.Shah@amd.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>
List-Id: linux-i2c@vger.kernel.org

On 10.02.2017 08:38, Suravee Suthikulpanit wrote:
> At this points, my understanding is there are probably two options here:
>
> 1) Keep the commit 63d0f0a6952a (i2c: designware: detect when dynamic
> tar update
>    is possible) and apply V2 of this patch in 4.10. We might need to
> back-port the change
>    to v4.9 stable as well.
>
> 2) Revert the 63d0f0a6952a (i2c: designware: detect when dynamic tar
> update is possible) in 4.10,
>    and also in v4.9 stable as well.
>
I'm fine with both options. Maybe revert as commit 0317e6c0f1dc ("i2c: 
designware: do not disable adapter after transfer") was also reverted 
and this revert doesn't seem to cause conflicts.

-- 
Jarkko
