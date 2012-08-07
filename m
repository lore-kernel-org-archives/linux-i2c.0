From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v7] ARM: davinci: i2c: add OF support
Date: Tue, 07 Aug 2012 16:35:16 +0200
Message-ID: <502127A4.2040505@denx.de>
References: <1343632872-25896-1-git-send-email-hs@denx.de>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1343632872-25896-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On 30.07.2012 09:21, Heiko Schocher wrote:
> add of support for the davinci i2c driver.
>
> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
> Signed-off-by: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
> Cc: Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> ---
> - changes for v2:
> - add comments from Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>    - use "cell-index" instead "id"
>    - OF_DEV_AUXDATA in the machine code, instead pre-define platform
>      device name
> - add comment from Grant Likely:
>    - removed "id" resp. "cell-index" completely
>    - fixed documentation
>    - use of_match_ptr()
>    - use devm_kzalloc() for allocating plattform data mem
>    - fixed a whitespace issue
> - no changes for v3
> - changes for v4
>    remove "pinmux-handle" property as discussed here:
>    http://www.spinics.net/lists/arm-kernel/msg175701.html
>    with Nori Sekhar
>
> - changes for v5
>    add comments from Grant Likely:
>    - do not change value of dev->dev->platform_data, instead
>      hold a copy in davinci_i2c_dev.
>
> - changes for v6:
>    add comments from Sekhar Nori:
>    - removed unneccessary include
>    - merge patch from Sekhar Nori:
>      setup the newly introduced dev->pdata member correctly once in
>      probe ->  i2c_get_plattformdata(() not needed, remove a lot of
>      checks for pdata in code
>    - add Signed-off-by: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>    - patch no longer in patchserie, as it has no dependencies.
>
> - changes for v7:
>    add comments from Wolfram Sang:
>    - move Documentation/devicetree/bindings/arm/davinci/i2c.txt
>      to Documentation/devicetree/bindings/i2c/davinci.txt
>    - remove bus-delay property
>
>   Documentation/devicetree/bindings/i2c/davinci.txt |   28 ++++++++++++
>   drivers/i2c/busses/i2c-davinci.c                  |   48 ++++++++++++++++-----
>   2 files changed, 65 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/i2c/davinci.txt

ping ... any comments?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
