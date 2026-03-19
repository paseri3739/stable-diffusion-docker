# stable-diffusion-docker

`AUTOMATIC1111/stable-diffusion-webui` の `dev` ブランチを、コミット `1937682a20f7f0442311a1ede68f9f0cb480163b` に固定した Docker Compose 構成です。

## 方針

- サブモジュールは `stable-diffusion-webui` のみ
- スーパーリポジトリ側でサブモジュールのコミットを固定
- `docker compose up -d` だけで起動
- 実行時の `COMMANDLINE_ARGS` は `.env` で管理
- 依存解決済みの `venv` を Docker イメージに含める
- ユーザーデータは `data/` 配下に、A1111 のルート構成に合わせて配置

## 使い方

1. `data/models/Stable-diffusion/` などに必要なモデルを配置します。
2. 必要なら `.env` の `A1111_COMMANDLINE_ARGS` を調整します。
3. `docker compose up -d --build` を実行します。
4. ブラウザで `http://localhost:7860` を開きます。

## メモ

- `stable-diffusion-webui` は `dev` ブランチ追従ではなく、現在は固定コミットで止まります。
- Hugging Face などのキャッシュも `data/cache/` に集約します。
- `data/` は bind mount 前提なので、ホスト側で直接バックアップできます。
- NixOS では `gpus: all` より CDI デバイス指定のほうが実用的なため、Compose では `devices: [nvidia.com/gpu=all]` 相当を使っています。
- NixOS 側では `hardware.nvidia-container-toolkit.enable = true;` に加えて、Docker の CDI を有効化した状態を前提にしています。
