From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated ACPI-enabled
 platforms not currently supported
Date: Fri, 21 Oct 2016 10:56:24 +0100
Message-ID: <76ab13e9-9aa5-97c3-2328-928bbcef9877@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
 <20161014173014.GA26269@leverpostej> <20161014182045.GA1509@katana>
 <55cc91af-8d24-8aea-f74f-2ef40cd8ea5a@synopsys.com>
 <20161018151706.GA1433@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161018151706.GA1433@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Luis.Oliveira@synopsys.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Since practically 90% of the code is shared between master and slave, I was
thinking if it will be acceptable to use the same driver for both but
differentiate the master/slave mode by the compatible strings.

Thanks,
Luis

On 10/18/2016 16:17, Wolfram Sang wrote:
>> This is needed because the configuration is different and the i2c-designware
>> cannot be master/slave without a reset. To resolve that I added this property
>> to bind it as a slave when needed.
> Aww, pity that the HW can't do that. Do you have details why?
>
> If that is really a HW limitation, then I'd suggest having a seperate
> driver for slave-only mode so we can differentiate by compatible
> strings.
>
