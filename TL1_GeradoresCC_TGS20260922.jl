### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lab-report", "module1"]
#> title = "📄 TL1: Geradores de Corrente Contínua"
#> layout = "layout.jlhtml"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ e68ce25e-d0fc-48ab-bf35-5a7476a5f51d
using PlutoUI, PlutoTeachingTools, Handcalcs, Plots
# Short packages description:
  # PlutoUI.jl, para adicionar objetos de interatividade ao notebook
  # PlutoTeachingTools.jl, para melhorar a apresentação do notebook (aside, TableOfContents, etc.)
  # Handcalcs.jl, para mostrar cálculos simbólicos formatados em LaTeX
  # Plots.jl, para traçar as curvas características obtidas

# ╔═╡ 91180300-0b49-4211-9ad3-12fd0785f518
TwoColumnWideLeft(md"`TL1_GeradoresCC.jl`", md"`Last update: 22·09·2026`")

# ╔═╡ 01c6c856-fa22-4f37-85fc-8225cb900e33
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS DE CORRENTE CONTÍNUA}$

$\text{RELATÓRIO}$

$\textbf{TL1: Geradores de Corrente Contínua}$

---
"""

# ╔═╡ bc249455-d545-4b18-9a03-9d2d9845dd3c
md"""
**Instituição:** ISEL — Instituto Superior de Engenharia de Lisboa \
**Curso:** Licenciatura em Engenharia Eletrotécnica \
**Unidade Curricular:** Máquinas Eléctricas II

**Grupo de trabalho:** _(n.ºs e nomes)_ \
**Data do ensaio:** _(dd/mm/aaaa)_
"""

# ╔═╡ 645af5c7-dd7b-4aa5-b895-0b46954fa592
md"""
# 1 - Introdução
"""

# ╔═╡ a980a0eb-d2e6-40e5-9455-e850c37c1062
md"""
As máquinas de Corrente Contínua (CC) classificam-se quanto ao tipo de excitação utilizado no(s) circuito(s) indutor(es). No funcionamento como **gerador CC** distinguem-se dois grupos principais:

- **Gerador CC de excitação separada (ou independente)**, em que o circuito indutor é alimentado por uma fonte CC externa;
- **Geradores CC autoexcitados**, em que o(s) circuito(s) indutor(es) é(são) alimentado(s) pela própria tensão produzida no induzido.

Para a caracterização completa de um gerador CC consideram-se três curvas características:

- **Característica magnética ou de vazio**, $E_0=f(I_{exc})$, à velocidade constante;
- **Característica externa**, $U=f(I)$, com $n$ e $I_{exc}$ constantes;
- **Característica de regulação**, $I_{exc}=f(I)$, com $U$ e $n$ constantes.
"""

# ╔═╡ 010f9a4e-8682-4757-8bc8-ba8e4f69cc9b
md"""
## 1.1 - Objectivos
"""

# ╔═╡ 3922df4d-00bf-49ae-bdd8-32e63e66a266
md"""
Com a realização do TL1 pretende-se que o grupo de trabalho fique apto a:

1. Conceber e executar esquemas eléctricos de geradores de CC;
1. Operar geradores CC com diferentes tipos de excitação;
1. Conduzir ensaios para obtenção de curvas características de funcionamento de geradores CC;
1. Distinguir os processos de regulação da tensão de saída de um gerador CC;
1. Analisar comparativamente as curvas características de geradores CC.
"""

# ╔═╡ 9ef12029-565b-4a7c-8075-da777a76159d


# ╔═╡ 89bb091f-26df-440d-8019-c16c2eecd530
md"""
# 2 - Procedimento de ensaio
"""

# ╔═╡ 6409f05e-f99f-44b2-96b4-6c2d28739fc2
md"""
## 2.1 - Esquema(s) de ligações

(📌 Inserir o(s) esquema(s) de ligações eléctricas utilizado(s) em cada ensaio, com simbologia normalizada IEC 60617.)
\
\
\
\
\
\
\
\
"""

# ╔═╡ eb7ff773-63a0-467d-9aa6-e49de889d3a0
md"""
## 2.2 - Material utilizado

(📌 Listar o material utilizado: máquina CC a ensaiar, máquina de arrastamento, quadros de medida, reóstatos de campo e de carga, aparelhos de medida e respectivas classes de precisão.)
\
\
\
\
\
"""

# ╔═╡ cc78dac9-e63b-4354-8a84-5a042ed9dac1
md"""
## 2A - TL1.1: Gerador CC de excitação separada
"""

# ╔═╡ a3189194-75dc-47ae-8523-4bfea21c039f
md"""
**Condução do trabalho:**

1. Montar o gerador CC em excitação separada, alimentando o circuito indutor a partir de uma fonte CC independente;
1. **Ensaio em vazio**, à corrente de carga nula, para duas velocidades constantes e distintas, $n_1$ e $n_2$: variar $I_{exc}$ e registar $E_0$, obtendo a característica magnética às duas velocidades;
1. **Ensaio em carga**, à velocidade constante, para caracterização do circuito induzido: variar a corrente de carga $I$ e registar $U$;
1. Regular um ponto de funcionamento do gerador em carga (por exemplo, tensão nominal para uma dada corrente de carga), ajustando $I_{exc}$.
"""

# ╔═╡ 7ae3014e-1044-4bd3-b204-01be0c96ccb3
md"""
### 2A.1 - 💻 Dados de placa do gerador CC ensaiado
"""

# ╔═╡ a33ed3b5-55d3-4ce8-aa0e-ba780d5e6117
md"""
Introduzir os dados de placa característica do gerador CC (📌 substituir pelos valores reais):

 $$U_N=$$ $(@bind Un NumberField(0:1:1000, default=220)) V $\qquad$ $$I_N=$$ $(@bind In NumberField(0:0.1:200, default=10.0)) A

 $$P_N=$$ $(@bind Pn NumberField(0:10:100000, default=2000)) W $\qquad$ $$n_N=$$ $(@bind nN NumberField(0:10:10000, default=1500)) rpm

 $$R_i=$$ $(@bind Ri NumberField(0:0.01:100, default=1.0)) Ω
"""

# ╔═╡ e7603af8-7535-4feb-ba07-c1f11b7dd12a
md"""
## 2B - TL1.2: Características externas de geradores autoexcitados
"""

# ╔═╡ e7a1e2b5-eb45-41e7-9f7b-0780388ca5fd
md"""
**Condução do trabalho:**

1. Modificar a montagem anterior, ligando o gerador em **excitação derivação** (o circuito indutor é alimentado pela tensão do induzido);
1. Ensaiar o gerador em carga variável, à velocidade constante, mantendo $I_{exc}$ ajustado no início do ensaio (sem reajuste) e registar $U=f(I)$;
1. Modificar a montagem para **excitação composta**, associando o enrolamento série;
1. Repetir o ensaio em carga variável, registando $U=f(I)$, para as ligações composta aditiva e/ou subtractiva, consoante indicação do docente;
1. Verificar e comentar a influência do enrolamento série no comportamento do gerador autoexcitado.
"""

# ╔═╡ 3e60c372-1012-4fd7-8f52-67acc1e5e38a


# ╔═╡ a0496a7f-11c1-4beb-b381-1fa90f532637
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ 3904d927-0af7-420f-b0ad-ef3ab548369d
md"""
Apresentam-se, de seguida, os dados registados em laboratório e os respectivos gráficos, sem interpretação nesta fase (a discussão dos resultados é feita na secção 4).
"""

# ╔═╡ a039fc07-82b8-4560-8674-7aef5e56711d
md"""
## 3.1 - TL1.1: Gerador CC de excitação separada

### 3.1.1 - 💻 Ensaio em vazio — característica magnética

(📌 Substituir os vectores pelos valores medidos em laboratório, para as duas velocidades ensaiadas.)
"""

# ╔═╡ a0698ece-356a-4a9d-8ccc-bc641c5090c6
begin
	# Ensaio em vazio, velocidade n₁ (rpm)
	Iexc_v1 = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]   # A - corrente de excitação
	E0_v1   = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]   # V - f.e.m. induzida

	# Ensaio em vazio, velocidade n₂ (rpm)
	Iexc_v2 = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]   # A - corrente de excitação
	E0_v2   = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]   # V - f.e.m. induzida
end

# ╔═╡ a0698ece-356a-4a9d-8ccc-bc641c5090c7
begin
	plot(Iexc_v1, E0_v1, marker=:circle, label="n₁ = _ rpm",
		xlabel="Iₑₓ𝒸 (A)", ylabel="E₀ (V)",
		title="Característica magnética (vazio)", legend=:bottomright)
	plot!(Iexc_v2, E0_v2, marker=:square, label="n₂ = _ rpm")
end

# ╔═╡ 5257b7b7-8c4f-4dc3-897d-24683c71bbd2
md"""
### 3.1.2 - 💻 Ensaio em carga — característica externa do induzido

(📌 Substituir pelos valores medidos; indicar o valor de $I_{exc}$ e a velocidade mantidos constantes durante o ensaio.)
"""

# ╔═╡ bbb480d5-8c96-4186-abbb-0db9b6bebe86
begin
	I_carga = [0.0, 2.0, 4.0, 6.0, 8.0, 10.0]   # A - corrente de carga
	U_carga = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]    # V - tensão nos terminais
end

# ╔═╡ 638f6aa1-db44-4777-9e2a-c6fe30df9900
plot(I_carga, U_carga, marker=:circle, label="Excitação separada",
	xlabel="I (A)", ylabel="U (V)",
	title="Característica externa do induzido", legend=:bottomleft)

# ╔═╡ 89bc678a-5637-486b-83a4-9581c10c5a0c
md"""
## 3.2 - TL1.2: Geradores autoexcitados

### 3.2.1 - 💻 Característica externa — excitação derivação

(📌 Substituir pelos valores medidos, sem reajuste de $I_{exc}$ durante o ensaio.)
"""

# ╔═╡ 9b3e14dd-69ff-42db-932c-c073c0aba53b
begin
	I_der = [0.0, 2.0, 4.0, 6.0, 8.0, 10.0]   # A
	U_der = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]    # V
end

# ╔═╡ f399d96b-df4a-455a-9b16-342888175b4d
plot(I_der, U_der, marker=:circle, label="Excitação derivação",
	xlabel="I (A)", ylabel="U (V)",
	title="Característica externa — excitação derivação", legend=:bottomleft)

# ╔═╡ e3556745-7d1a-4840-9ed5-a2b3b004c131
md"""
### 3.2.2 - 💻 Característica externa — excitação composta

(📌 Substituir pelos valores medidos. Indicar se a ligação é aditiva ou subtractiva.)
"""

# ╔═╡ a4661648-771a-4655-ab1e-1d242d7e7102
begin
	I_comp = [0.0, 2.0, 4.0, 6.0, 8.0, 10.0]   # A
	U_comp = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]    # V
end

# ╔═╡ 0ad40542-0868-4cf0-9cd0-e6b9dccc7a43
begin
	plot(I_der, U_der, marker=:circle, label="Derivação",
		xlabel="I (A)", ylabel="U (V)",
		title="Comparação de características externas", legend=:bottomleft)
	plot!(I_comp, U_comp, marker=:square, label="Composta")
end

# ╔═╡ ee4a8bbb-cf9a-42e4-86e8-9ea1554b520c
md"""
# 4 - Análise de resultados
"""

# ╔═╡ 86001c95-03d8-4f09-931b-328dc1263112
aside(md"""
!!! info "Nota:"
	As respostas às questões seguintes devem fundamentar-se nos resultados apresentados na secção 3.
""", v_offset=-60)

# ╔═╡ 18c407a5-a264-496a-ab6d-2600d1449d70
md"""
(📌 Responder de forma fundamentada.)

- Quais as condições necessárias para a autoexcitação de um gerador CC?
- Comparar as características externas obtidas para os diferentes tipos de excitação (separada, derivação, composta).
- Definir e comentar uma característica de regulação para o gerador CC ensaiado.
- Qual a influência do enrolamento série no funcionamento do gerador autoexcitado (TL1.2)?
"""

# ╔═╡ f92cd1cc-cf0d-41c6-bb81-77ad0fdbd449
md"""
### 💻 Determinação das quedas de tensão do gerador (excitação separada)

Para um ponto de funcionamento em carga (📌 substituir $I$ pelo valor de ensaio pretendido), a queda de tensão na resistência do induzido é:
"""

# ╔═╡ 5da2eff5-2eaa-4ae0-8dbe-3d97efeb1a2e
@handcalcs begin
	I = 5.0   # A - 📌 substituir pelo valor de corrente de carga a analisar
	ΔU_Ri = Ri * I
end

# ╔═╡ 0c3e7c22-6b3e-48ce-b6bc-1503f25d52cb
md"""
(📌 Comentar esta queda de tensão face à diferença observada entre $E_0$, em vazio, e $U$, em carga, no mesmo ponto de funcionamento — a diferença remanescente corresponde à reacção magnética do induzido e à queda nas escovas.)
"""

# ╔═╡ 962c8fb7-d27c-4228-98a2-27350a218ea7
md"""
# 5 - Conclusões
"""

# ╔═╡ 1c2c6f3f-01e4-456f-be77-7429ebae3d8e
md"""
(📌 Sintetizar os aspectos fundamentais do trabalho, relacionando-os com os objectivos definidos na secção 1.1.)
\
\
\
\
\
\
"""

# ╔═╡ ac89be53-8995-4932-acfa-0a5827bac41a
md"""
# Referências
"""

# ╔═╡ f5e016f0-21f9-478e-9fc6-77d6d06fee8c
md"""
1. R. Luís, *Enunciados dos Trabalhos Laboratoriais — Máquinas Eléctricas II*, recurso educacional aberto, ISEL, 2026.
1. (📌 Acrescentar bibliografia de apoio consultada pelo grupo — norma IEEE, ISO 690 ou NP 405.)
"""

# ╔═╡ ce1154ab-c91c-4857-beb4-92b24fc59fc3
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%;
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%;
	text-align: justify
}
</style>
"""

# ╔═╡ 8a0c2b1f-6f19-4e2a-9d3b-3c9a1a5b8d21
md"""
# Notebook
"""

# ╔═╡ 3a1f7b2c-9d4e-4b6a-8c2f-7e5d9a0b1c34
TableOfContents(title="Índice")

# ╔═╡ b6c8e2a1-4d3f-4a7b-9e1c-2f0d8b5a6e73
aside((md"""
!!! info
	No índice deste *notebook*, as secções assinaladas com "💻" requerem a introdução de dados/valores medidos pelo grupo de trabalho.
"""), v_offset=-170)

# ╔═╡ d1f4a9c3-7e2b-4d6a-8b1f-5a3c9e0d2f68
md"""
|  |  |
|:--:|:--|
|  | Relatório elaborado em Pluto.jl a partir da estrutura do TL1 — Geradores de Corrente Contínua, seguindo o modelo de *notebook* usado nas aulas práticas de Máquinas Eléctricas II, ISEL. |
"""

# ╔═╡ Cell order:
# ╠═e68ce25e-d0fc-48ab-bf35-5a7476a5f51d
# ╟─91180300-0b49-4211-9ad3-12fd0785f518
# ╟─01c6c856-fa22-4f37-85fc-8225cb900e33
# ╟─bc249455-d545-4b18-9a03-9d2d9845dd3c
# ╟─645af5c7-dd7b-4aa5-b895-0b46954fa592
# ╟─a980a0eb-d2e6-40e5-9455-e850c37c1062
# ╟─010f9a4e-8682-4757-8bc8-ba8e4f69cc9b
# ╟─3922df4d-00bf-49ae-bdd8-32e63e66a266
# ╟─9ef12029-565b-4a7c-8075-da777a76159d
# ╟─89bb091f-26df-440d-8019-c16c2eecd530
# ╟─6409f05e-f99f-44b2-96b4-6c2d28739fc2
# ╟─eb7ff773-63a0-467d-9aa6-e49de889d3a0
# ╟─cc78dac9-e63b-4354-8a84-5a042ed9dac1
# ╟─a3189194-75dc-47ae-8523-4bfea21c039f
# ╟─7ae3014e-1044-4bd3-b204-01be0c96ccb3
# ╟─a33ed3b5-55d3-4ce8-aa0e-ba780d5e6117
# ╟─e7603af8-7535-4feb-ba07-c1f11b7dd12a
# ╟─e7a1e2b5-eb45-41e7-9f7b-0780388ca5fd
# ╟─3e60c372-1012-4fd7-8f52-67acc1e5e38a
# ╟─a0496a7f-11c1-4beb-b381-1fa90f532637
# ╟─3904d927-0af7-420f-b0ad-ef3ab548369d
# ╟─a039fc07-82b8-4560-8674-7aef5e56711d
# ╠═a0698ece-356a-4a9d-8ccc-bc641c5090c6
# ╠═a0698ece-356a-4a9d-8ccc-bc641c5090c7
# ╟─5257b7b7-8c4f-4dc3-897d-24683c71bbd2
# ╠═bbb480d5-8c96-4186-abbb-0db9b6bebe86
# ╠═638f6aa1-db44-4777-9e2a-c6fe30df9900
# ╟─89bc678a-5637-486b-83a4-9581c10c5a0c
# ╠═9b3e14dd-69ff-42db-932c-c073c0aba53b
# ╠═f399d96b-df4a-455a-9b16-342888175b4d
# ╟─e3556745-7d1a-4840-9ed5-a2b3b004c131
# ╠═a4661648-771a-4655-ab1e-1d242d7e7102
# ╠═0ad40542-0868-4cf0-9cd0-e6b9dccc7a43
# ╟─ee4a8bbb-cf9a-42e4-86e8-9ea1554b520c
# ╟─86001c95-03d8-4f09-931b-328dc1263112
# ╟─18c407a5-a264-496a-ab6d-2600d1449d70
# ╟─f92cd1cc-cf0d-41c6-bb81-77ad0fdbd449
# ╠═5da2eff5-2eaa-4ae0-8dbe-3d97efeb1a2e
# ╟─0c3e7c22-6b3e-48ce-b6bc-1503f25d52cb
# ╟─962c8fb7-d27c-4228-98a2-27350a218ea7
# ╟─1c2c6f3f-01e4-456f-be77-7429ebae3d8e
# ╟─ac89be53-8995-4932-acfa-0a5827bac41a
# ╟─f5e016f0-21f9-478e-9fc6-77d6d06fee8c
# ╟─ce1154ab-c91c-4857-beb4-92b24fc59fc3
# ╟─8a0c2b1f-6f19-4e2a-9d3b-3c9a1a5b8d21
# ╠═3a1f7b2c-9d4e-4b6a-8c2f-7e5d9a0b1c34
# ╟─b6c8e2a1-4d3f-4a7b-9e1c-2f0d8b5a6e73
# ╟─d1f4a9c3-7e2b-4d6a-8b1f-5a3c9e0d2f68
