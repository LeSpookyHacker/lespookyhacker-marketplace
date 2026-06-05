#!/usr/bin/env bash
# Girlypop UwU status line 🎀  —  model · dir · ctx% · random JP catchphrase · random anime kaomoji
# Claude Code pipes the session JSON in on stdin; we print one pastel line.
# NOTE: status lines are NOT auto-applied by plugins. To use this, add a
# `statusLine` block to your OWN ~/.claude/settings.json pointing at this file
# (see the plugin README for the exact snippet).
export PYTHONIOENCODING=utf-8

# Capture stdin (the session JSON) FIRST, then feed the PROGRAM to python via the
# heredoc. python reads its program from the heredoc, so the JSON must arrive via
# an env var, not stdin — otherwise the two would collide.
CC_INPUT="$(cat)"
export CC_INPUT

python3 <<'PY'
import os, json, random, sys

# --- parse session JSON (every field has a safe fallback) ---
try:
    d = json.loads(os.environ.get("CC_INPUT") or "{}")
except Exception:
    d = {}

model = (d.get("model") or {}).get("display_name") or "Claude"

ws = d.get("workspace") or {}
cur = ws.get("current_dir") or os.getcwd()
home = os.path.expanduser("~")
if cur.startswith(home):
    cur = "~" + cur[len(home):]
cur = os.path.basename(cur.rstrip("/")) or cur

cw = d.get("context_window") or {}
pct = cw.get("used_percentage", 0)
try:
    pct = int(float(pct))
except Exception:
    pct = 0

# --- the random catchphrase channel ✨ (kana/kanji + romaji) ---
phrases = [
    # -- core --
    "頑張って！(ganbatte!)",
    "やったー！(yatta~!)",
    "できた！(dekita!)",
    "すごい！(sugoi!)",
    "完璧！(kanpeki!)",
    "任せて！(makasete!)",
    "大丈夫だよ〜 (daijoubu~)",
    "お疲れ様〜 (otsukaresama~)",
    "最高！(saikou!)",
    "なるほど！(naruhodo!)",
    "よかった〜 (yokatta~)",
    "ファイト！(faito!)",
    "かわいい！(kawaii!)",
    "バグ発見！(bagu hakken!)",
    # -- energy / momentum --
    "行くよ！(iku yo!)",
    "やってみる！(yatte miru!)",
    "もうちょっと！(mou chotto!)",
    "ほぼできた！(hobo dekita!)",
    "いい感じ！(ii kanji!)",
    "急いで！(isoide!)",
    "集中〜 (shuuchuu~)",
    "おまかせあれ！(omakase are!)",
    "やっぱり！(yappari!)",
    "さすが！(sasuga!)",
    "一緒に頑張ろう！(issho ni ganbarou!)",
    "よろしく！(yoroshiku!)",
    # -- celebration / reaction --
    "きゃー！(kyaa!)",
    "うれし〜！(ureshi~!)",
    "最強！(saikyou!)",
    "神！(kami!)",
    "素晴らしい！(subarashii!)",
    "天才！(tensai!)",
    "やばい！(yabai!)",
    "感動した〜 (kandou shita~)",
    "えーっ！(ee~!)",
    "マジで？(maji de?)",
    "うそ〜！(uso~!)",
    "本当に？(hontou ni?)",
    "まじすか！(maji suka!)",
    "ありがとう！(arigatou!)",
    # -- coding-specific --
    "テスト通過！(tesuto tsuuka!)",
    "実装完了！(jissou kanryou!)",
    "修正完了！(shuusei kanryou!)",
    "デバッグ中〜 (debagg-chuu~)",
    "原因発見！(gen'in hakken!)",
    "直した！(naoshita!)",
    "あぶなかった〜 (abunakatta~)",
    "あれっ？(are~?)",
    # -- gentle / soft --
    "ごめんね〜 (gomen ne~)",
    "大丈夫？(daijoubu?)",
    "無理しないで (muri shinaide)",
    "ゆっくりね〜 (yukkuri ne~)",
    "ちょっと待って！(chotto matte!)",
    "しょうがないか〜 (shouganai ka~)",
    # -- coding energy --
    "コードを書くよ！(koodo wo kaku yo~)",
    "さいこーすぎる！(saikoo sugiru!)",
    "わあ〜！(waa~!)",
    "やん！(yan!)",
    # -- japanese onomatopoeia --
    "ドキドキ〜 (doki doki~)",
    "キラキラ！(kira kira!)",
    "わくわく〜 (waku waku~)",
    "ぴかぴか！(pika pika!)",
    "にこにこ〜 (niko niko~)",
    "ふわふわ〜 (fuwa fuwa~)",
    "もふもふ〜 (mofu mofu~)",
]
phrase = random.choice(phrases)

# --- 256-color pastel palette ---
HOT  = "\033[38;5;211m"   # hot pink
PINK = "\033[38;5;218m"   # light pink
LAV  = "\033[38;5;183m"   # lavender
MINT = "\033[38;5;157m"   # mint
DIM  = "\033[38;5;245m"   # grey separators
R    = "\033[0m"

kaomoji = [
    # -- sparkle / starry --
    "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧",
    "ヽ(>∀<☆)ノ",
    "(★ω★)",
    "✧.(◍•ᴗ•◍).✧",
    "(⌒▽⌒)☆",
    # -- hearts --
    "(。♥‿♥。)",
    "٩(◕‿◕｡)۶",
    "(●♡∀♡)",
    "(灬º‿º灬)♡",
    "(*˘︶˘*).｡.:*♡",
    # -- happy / excited --
    "o(≧▽≦)o",
    "(◕‿◕✿)",
    "(≧◡≦)",
    "(*^▽^*)",
    "♪(๑ᴖ◡ᴖ๑)♪",
    # -- soft / shy --
    "(˶˃ ᵕ ˂˶)",
    "(っ˘ω˘ς )",
    "(。・ω・。)",
    "(✿◠‿◠)",
    # -- anime reaction --
    "(｡>﹏<｡)",
    "。゚(TヮT)゚。",
    "( ˶°ㅇ°˶)",
]
kmoji = random.choice(kaomoji)

bar = (
    f"{HOT}🎀{R} {PINK}{model}{R} "
    f"{DIM}·{R} {LAV}📁 {cur}{R} "
    f"{DIM}·{R} {MINT}🌸 {pct}%{R} "
    f"{DIM}·{R} {PINK}{phrase}{R} {HOT}{kmoji}{R}"
)

# force UTF-8 bytes out (LANG may be unset)
try:
    sys.stdout.buffer.write(bar.encode("utf-8") + b"\n")
except Exception:
    print(bar)
PY
