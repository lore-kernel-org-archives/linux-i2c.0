From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 22/22] docs: fix broken documentation links
Date: Mon, 3 Jun 2019 09:34:15 +0200
Message-ID: <64e136de-1a7b-3436-9675-44ea9fa7b64a@c-s.fr>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
Content-Language: fr
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Preston <thomas.preston@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>, Alessia Mantegazza <amantegazza@vaga.pv.it>, Jakub Wilk <jwilk@jwilk.net>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Kevin Hilman <khilman@baylibre.com>, James Morris <jmorris@namei.org>, linux-acpi@vger.kernel.org, Andy Gross <agross@kernel.org>, xen-devel@lists.xenproject.org, Jason Wang <jasowang@redhat.com>, Alexander Popov <alex.popov@linux.com>, Qian Cai <cai@lca.pw>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kairui Song <kasong@redhat.com>, Quentin Perret <quentin.perret@arm.com>, Greg
List-Id: linux-i2c@vger.kernel.org



Le 30/05/2019 à 01:23, Mauro Carvalho Chehab a écrit :
> Mostly due to x86 and acpi conversion, several documentation
> links are still pointing to the old file. Fix them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   Documentation/acpi/dsd/leds.txt                  |  2 +-
>   Documentation/admin-guide/kernel-parameters.rst  |  6 +++---
>   Documentation/admin-guide/kernel-parameters.txt  | 16 ++++++++--------
>   Documentation/admin-guide/ras.rst                |  2 +-
>   .../devicetree/bindings/net/fsl-enetc.txt        |  7 +++----
>   .../bindings/pci/amlogic,meson-pcie.txt          |  2 +-
>   .../bindings/regulator/qcom,rpmh-regulator.txt   |  2 +-
>   Documentation/devicetree/booting-without-of.txt  |  2 +-
>   Documentation/driver-api/gpio/board.rst          |  2 +-
>   Documentation/driver-api/gpio/consumer.rst       |  2 +-
>   .../firmware-guide/acpi/enumeration.rst          |  2 +-
>   .../firmware-guide/acpi/method-tracing.rst       |  2 +-
>   Documentation/i2c/instantiating-devices          |  2 +-
>   Documentation/sysctl/kernel.txt                  |  4 ++--
>   .../translations/it_IT/process/howto.rst         |  2 +-
>   .../it_IT/process/stable-kernel-rules.rst        |  4 ++--
>   .../translations/zh_CN/process/4.Coding.rst      |  2 +-
>   Documentation/x86/x86_64/5level-paging.rst       |  2 +-
>   Documentation/x86/x86_64/boot-options.rst        |  4 ++--
>   .../x86/x86_64/fake-numa-for-cpusets.rst         |  2 +-
>   MAINTAINERS                                      |  6 +++---
>   arch/arm/Kconfig                                 |  2 +-
>   arch/arm64/kernel/kexec_image.c                  |  2 +-
>   arch/powerpc/Kconfig                             |  2 +-
>   arch/x86/Kconfig                                 | 16 ++++++++--------
>   arch/x86/Kconfig.debug                           |  2 +-
>   arch/x86/boot/header.S                           |  2 +-
>   arch/x86/entry/entry_64.S                        |  2 +-
>   arch/x86/include/asm/bootparam_utils.h           |  2 +-
>   arch/x86/include/asm/page_64_types.h             |  2 +-
>   arch/x86/include/asm/pgtable_64_types.h          |  2 +-
>   arch/x86/kernel/cpu/microcode/amd.c              |  2 +-
>   arch/x86/kernel/kexec-bzimage64.c                |  2 +-
>   arch/x86/kernel/pci-dma.c                        |  2 +-
>   arch/x86/mm/tlb.c                                |  2 +-
>   arch/x86/platform/pvh/enlighten.c                |  2 +-
>   drivers/acpi/Kconfig                             | 10 +++++-----
>   drivers/net/ethernet/faraday/ftgmac100.c         |  2 +-
>   .../fieldbus/Documentation/fieldbus_dev.txt      |  4 ++--
>   drivers/vhost/vhost.c                            |  2 +-
>   include/acpi/acpi_drivers.h                      |  2 +-
>   include/linux/fs_context.h                       |  2 +-
>   include/linux/lsm_hooks.h                        |  2 +-
>   mm/Kconfig                                       |  2 +-
>   security/Kconfig                                 |  2 +-
>   tools/include/linux/err.h                        |  2 +-
>   tools/objtool/Documentation/stack-validation.txt |  4 ++--
>   tools/testing/selftests/x86/protection_keys.c    |  2 +-
>   48 files changed, 77 insertions(+), 78 deletions(-)

[...]

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8c1c636308c8..e868d2bd48b8 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -898,7 +898,7 @@ config PPC_MEM_KEYS
>   	  page-based protections, but without requiring modification of the
>   	  page tables when an application changes protection domains.
>   
> -	  For details, see Documentation/vm/protection-keys.rst
> +	  For details, see Documentation/x86/protection-keys.rst

It looks strange to reference an x86 file, for powerpc arch.

Christophe
