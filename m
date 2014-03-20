From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 2/2] ARM: zynq: dt: Add I2C nodes to Zynq device tree
Date: Thu, 20 Mar 2014 12:35:45 +0100
Message-ID: <ff9e2fa6-5202-4b2a-967c-a9cb14463276@CH1EHSMHS003.ehs.local>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com> <1394556613-11692-2-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1394556613-11692-2-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-doc-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Harini Katakam <harinik@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On 03/11/2014 05:50 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v3:
>  - no changes
> v2:
>  - replace 'pmbus' with 'ti' in compatibility strings of UCD devices
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)

Rob, Mark: Any problem with binding?

Thanks,
Michal


