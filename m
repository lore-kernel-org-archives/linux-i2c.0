Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9CAC25B41
	for <linux-i2c@archiver.kernel.org>; Sun, 22 Oct 2023 15:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjJVPqM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 22 Oct 2023 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjJVPqK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 22 Oct 2023 11:46:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE5F3;
        Sun, 22 Oct 2023 08:46:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8D6C433C7;
        Sun, 22 Oct 2023 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989568;
        bh=Xo1aAShOpDFjWy+HRaK/7Q6/WA9vzKHM+5HWt4xx4Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2laS/JT7gVy922d3l/258y6M8rdxC5VoX389qLWOVndwzYQb505bzl1+jTOgCfpC
         og7V5Exd7TCPwBrMqT+S++AV+Cv/lLL5QIZk/k8o1PwYIfiUBryxoCM2/AJlISYlZb
         HwDeU3zfVS7hlQzJLZL2yM5yz0yPPYwXTZETXm8pulXBG4DsuSelLPlq40RZPUJX+H
         Fwn/L4fHf2fxCoS1rZMmlQk71DimEwao7HQ9gv7iE7RYER6i6gzZvaS0VuW/7HEhbJ
         9byoocsijjlM98DMyV5shvJFSQD76H7k/lcpiRzOVCmzbQ6iPdVskRnxp9/a+hJPOT
         exyayAV9vwq6g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Add CCI support for SC7280
Date:   Sun, 22 Oct 2023 08:50:16 -0700
Message-ID: <169798982325.271027.1504545156625784176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002-sc7280-cci-v2-0-9333fda4612a@fairphone.com>
References: <20231002-sc7280-cci-v2-0-9333fda4612a@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


On Mon, 02 Oct 2023 08:55:29 +0200, Luca Weiss wrote:
> Add the dts nodes for the camera control interface found on the SC7280
> SoC. And then enable the CCI nodes in the Fairphone 5 dts.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: Add Camera Control Interface busses
      commit: 0c149ca7653286496130e872f47a4b834348ea10

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
