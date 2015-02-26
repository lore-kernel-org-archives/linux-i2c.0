From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/8] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Thu, 26 Feb 2015 14:46:29 -0700
Message-ID: <54EF9435.1060806@wwwdotorg.org>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com> <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Gabriel Dobato <dobatog@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 02/17/2015 11:52 AM, Sebastian Hesselbarth wrote:
> I2C mux pinctrl driver currently determines the number of sub-busses by
> counting available pinctrl-names. Unfortunately, this requires each
> incarnation of the devicetree node with different available sub-busses
> to be rewritten.
>
> This patch reworks i2c-mux-pinctrl driver to count the number of
> available sub-nodes instead. The rework should be compatible to the old
> way of probing for sub-busses and additionally allows to disable unused
> sub-busses with standard DT property status = "disabled".
>
> This also amends the corresponding devicetree binding documentation to
> reflect the new functionality to disable unused sub-nodes. While at it,
> also fix two references to binding documentation files that miss an "i2c-"
> prefix.

Tested-by: Stephen Warren <swarren@nvidia.com>

(Both the HDMI and LCD panel DDC busses on NVIDIA Tegra 
Springbank/Seaboard, running next-20150224)
