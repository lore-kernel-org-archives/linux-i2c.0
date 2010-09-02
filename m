From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Thu, 2 Sep 2010 14:54:52 -0700
Message-ID: <AANLkTimd2D+_xQ_CH-e+jgn+rZgMpJY6Zkc-SSVdFzMt@mail.gmail.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<4C6168E9.1070405@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C6168E9.1070405@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 10, 2010 at 7:57 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> Hi Colin,
> Two more comments.
>
> Colin Cross wrote:
>>
>> From: Colin Cross <ccross@android.com>
>>
>> CC: linux-i2c@vger.kernel.org
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> =A0drivers/i2c/busses/Kconfig =A0 =A0 | =A0 =A07 +
>> =A0drivers/i2c/busses/Makefile =A0 =A0| =A0 =A01 +
>> =A0drivers/i2c/busses/i2c-tegra.c | =A0665
>> ++++++++++++++++++++++++++++++++++++++++
>> =A0include/linux/i2c-tegra.h =A0 =A0 =A0| =A0 25 ++
>
> This should probably go to arch/arm/mach-tegra/include/mach/ to minimize =
the
> pollution in include/linux
The existing standard seems to be to use include/linux

>> =A04 files changed, 698 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/i2c/busses/i2c-tegra.c
>> =A0create mode 100644 include/linux/i2c-tegra.h
>>
>
> [ snip ]
>
>> +
>> +static int __init tegra_i2c_init_driver(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_register(&tegra_i2c_driver);
>> +}
>> +module_init(tegra_i2c_init_driver);
>
> subsys_initcall would be better here.
This can be compiled as a module, subsys_initcall would break that.
