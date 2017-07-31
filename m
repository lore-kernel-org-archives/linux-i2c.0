From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 23:32:11 +0200
Message-ID: <0f26770f-804a-2730-a893-b63dc7e7c221@axentia.se>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170731231509.77d1fba4@bbrezillon>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ku
List-Id: linux-i2c@vger.kernel.org

On 2017-07-31 23:15, Boris Brezillon wrote:
> [1]https://www.mipi.org/MIPI_I3C_device_characteristics_register

Stupid non-programmers...

This part

65 41 01000001	Accelerometer
66 42 01000010	Gyroscope
67 43 01000011	Magnetometer
68 44 01000100	Accel/Gyro Combo
69 45 01000101	Accel/Mag Combo
70 46 01000110	Accel/Gyro/Mag Combo

should *obviously* have been something like

65 41 01000001	Accelerometer
66 42 01000010	Gyroscope
67 43 01000011	Accel/Gyro Combo
68 44 01000100	Magnetometer
69 45 01000101	Accel/Mag Combo
71 47 01000111	Accel/Gyro/Mag Combo

Cheers,
peda
