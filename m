From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: i3c: Document Qualcomm GENI I3C master
 bindings
Date: Thu, 09 Aug 2018 08:06:42 -0700
Message-ID: <153382720283.220756.3098223794140406023@swboyd.mtv.corp.google.com>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
 <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: Mike Shettel <mshettel@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, dianders@chromium.org, mka@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-i2c@vger.kernel.org

Quoting Mike Shettel (2018-07-31 22:39:01)
> Signed-off-by: Mike Shettel <mshettel@codeaurora.org>

You need to write some commit text here. Otherwise we don't know why we
want to even look at the patch.

> diff --git a/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt b/Do=
cumentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> new file mode 100644
> index 0000000..8b76fda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> @@ -0,0 +1,44 @@
[...]
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +       i3c-master@0d040000 {

Drop leading 0 on unit addresses.
