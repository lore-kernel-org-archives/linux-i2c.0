From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Tue, 15 Dec 2015 08:52:19 -0600
Message-ID: <56702923.9010305@amd.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151215132721.GJ1762@lahna.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Al Stone <al.stone@linaro.org>, Jeff.Wu@amd.com, jcm@redhat.com, wsa@the-dreams.de, rjw@rjwysocki.net, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, patches@apm.com, "Duran,
 Leo" <leo.duran@amd.com>, Loc Ho <lho@apm.com>, "Hurwitz,
 Sherry" <sherry.hurwitz@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Ken.Xue@amd.com, lenb@kernel.org
List-Id: linux-i2c@vger.kernel.org



On 12/15/2015 07:27 AM, Mika Westerberg wrote:
> On Mon, Dec 14, 2015 at 06:53:25PM -0600, Suravee Suthikulanit wrote:
>> >I'm not sure if this has been discussed earlier. But after looking at the
>> >the acpi_apd driver, all we need is just the platform-specific input clock
>> >frequency value used by the drivers/i2c/busses/i2c-designware-core.c:
>> >i2c_dw_init() to calculate the values to program into the DW_IC_SS_SCL_HCNT
>> >and DW_IC_SS_SCL_LCNT registers.
> There is a way to pass *CNT values already from ACPI to the driver -- It
> looks for method called FMCN (or SSCN) and retrieves the values from
> there if found.

Right, I also noticed this afterward. By the way, are FMCN and SSCN 
documented anywhere in the ACPI spec?  I am trying to figure out how to 
update the ACPI table to add this information for the AMD Seattle 
(ARM64) platform, and I will also submit a patch to add the new HID for 
this driver.

> The driver could be modified not to require clock if it already knows
> *CNT values.
>

Sounds good.

Thanks,
Suravee
