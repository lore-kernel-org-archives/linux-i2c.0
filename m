From: Jason Hui <jason.hui-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: About one i2c failure issue after system reset
Date: Mon, 21 Nov 2011 15:35:59 +0800
Message-ID: <CAFQ4atSRapXvhBnm=nH__zz2U=XRjxN4GK-JsXT=AEcKybANZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Ben, Jean,

I have one issue about the i2c failure: there will be on-going i2c
transfer while system get reset.
At the time when the reset happens, the slave may pull the SDA to
LOW.After reset, the i2c master may reset, but
the slave may still pull the SDA to LOW since there is no reset pin
for the slave device to do i2c reset, thus
result in the further i2c access failure forever unless we completely
power off the system by pulling out
the battery.

I know we have the shutdown member function, but as I know there is
very less i2c master has implemented this
function correctly. I think we need take seriously about this issue,
do you have any comments? Thanks,


Jason Liu
