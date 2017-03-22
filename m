From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: audio clk warnings during system suspend on Salvator-X
Date: Wed, 22 Mar 2017 09:43:55 +0100
Message-ID: <CAMuHMdUYbV-P86S3Jt3E0WJDhaBovFcv5z-yjVx6=otyQyWYxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34249 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758801AbdCVIoD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Mar 2017 04:44:03 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

Hi Morimoto-san, Wolfram,

During the second system suspend (suspend to mem, "deep") on H3 Salvator-X,
the clk subsystem prints warnings due to enable and prepare count imbalances.

With some additional debug code, I discovered the issue is caused by the
CS2000 clock driver failing to resume:

suspend #1:

    rsnd_adg_clk_control: called by rsnd_suspend
    rsnd_adg_clk_control: Disable audio_clk_a
    rsnd_adg_clk_control: Disable clk_multiplier
    rsnd_adg_clk_control: Disable audio_clk_c
    rsnd_adg_clk_control: Disable s0d4

resume #1:

    dpm_run_callback(): cs2000_resume+0x0/0x20 returns -6
    PM: Device 2-004f failed to resume early: error -6

    rsnd_adg_clk_control: called by rsnd_resume
    rsnd_adg_clk_control: Enable audio_clk_a
    rsnd_adg_clk_control: Enable clk_multiplier
    rcar_sound ec500000.sound: can't use clk 1
    rsnd_adg_clk_control: Enable audio_clk_c
    rsnd_adg_clk_control: Enable s0d4


suspend #2:

    rsnd_adg_clk_control: called by rsnd_suspend
    rsnd_adg_clk_control: Disable audio_clk_a
    rsnd_adg_clk_control: Disable clk_multiplier
    WARNING: CPU: 0 PID: 1943 at drivers/clk/clk.c:594
clk_core_disable+0x44/0x254
    [...]
    WARNING: CPU: 0 PID: 1943 at drivers/clk/clk.c:476
clk_core_unprepare+0x48/0x36c
    [...]
    rsnd_adg_clk_control: Disable audio_clk_c
    rsnd_adg_clk_control: Disable s0d4

resume #2:

    dpm_run_callback(): cs2000_resume+0x0/0x20 returns -6
    PM: Device 2-004f failed to resume early: error -6

    rsnd_adg_clk_control: called by rsnd_resume
    rsnd_adg_clk_control: Enable audio_clk_a
    rsnd_adg_clk_control: Enable clk_multiplier
    rcar_sound ec500000.sound: can't use clk 1
    rsnd_adg_clk_control: Enable audio_clk_c
    rsnd_adg_clk_control: Enable s0d4


The CS2000 driver fails to send an i2c message, probably because the
rcar-i2c driver lost some register settings during system suspend.  This does
not happen with s2idle.

I guess this is also the reason for this warning:

    ak4613-codec 2-0010: Unable to sync registers 0x0-0x2. -6

as the ak4613 is connected to the same i2c bus.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
